import 'dart:ui' as ui
    show
        Locale,
        LocaleStringAttribute,
        ParagraphBuilder,
        SpellOutStringAttribute,
        StringAttribute;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

@immutable
class MTextSpan extends InlineSpan
    implements HitTestTarget, MouseTrackerAnnotation {
  const MTextSpan({
    this.text,
    this.children,
    super.style,
    this.recognizer,
    MouseCursor? mouseCursor,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut,
    this.color,
    this.fontSize,
    this.isBold = false,
    this.fontWeight,
    this.overflow,
  })  : mouseCursor = mouseCursor ??
            (recognizer == null ? MouseCursor.defer : SystemMouseCursors.click),
        assert(!(text == null && semanticsLabel != null));

  final List<InlineSpan>? children;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isBold;
  final ui.Locale? locale;
  final MouseCursor mouseCursor;
  final TextOverflow? overflow;
  final GestureRecognizer? recognizer;
  final String? semanticsLabel;
  final bool? spellOut;
  final String? text;

  @override
  final PointerEnterEventListener? onEnter;

  @override
  final PointerExitEventListener? onExit;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (super != other) {
      return false;
    }
    return other is MTextSpan &&
        other.text == text &&
        other.recognizer == recognizer &&
        other.semanticsLabel == semanticsLabel &&
        onEnter == other.onEnter &&
        onExit == other.onExit &&
        mouseCursor == other.mouseCursor &&
        listEquals<InlineSpan>(other.children, children);
  }

  @override
  int? codeUnitAtVisitor(int index, Accumulator offset) {
    final String? text = this.text;
    if (text == null) {
      return null;
    }
    final int localOffset = index - offset.value;
    assert(localOffset >= 0);
    offset.increment(text.length);
    return localOffset < text.length ? text.codeUnitAt(localOffset) : null;
  }

  @override
  RenderComparison compareTo(InlineSpan other) {
    if (identical(this, other)) {
      return RenderComparison.identical;
    }
    if (other.runtimeType != runtimeType) {
      return RenderComparison.layout;
    }
    final MTextSpan textSpan = other as MTextSpan;
    if (textSpan.text != text ||
        children?.length != textSpan.children?.length ||
        (style == null) != (textSpan.style == null)) {
      return RenderComparison.layout;
    }
    RenderComparison result = recognizer == textSpan.recognizer
        ? RenderComparison.identical
        : RenderComparison.metadata;
    if (style != null) {
      final RenderComparison candidate = style!.compareTo(textSpan.style!);
      if (candidate.index > result.index) {
        result = candidate;
      }
      if (result == RenderComparison.layout) {
        return result;
      }
    }
    if (children != null) {
      for (int index = 0; index < children!.length; index += 1) {
        final RenderComparison candidate =
            children![index].compareTo(textSpan.children![index]);
        if (candidate.index > result.index) {
          result = candidate;
        }
        if (result == RenderComparison.layout) {
          return result;
        }
      }
    }
    return result;
  }

  @override
  void computeSemanticsInformation(
    List<InlineSpanSemanticsInformation> collector, {
    ui.Locale? inheritedLocale,
    bool inheritedSpellOut = false,
  }) {
    assert(debugAssertIsValid());
    final ui.Locale? effectiveLocale = locale ?? inheritedLocale;
    final bool effectiveSpellOut = spellOut ?? inheritedSpellOut;

    if (text != null) {
      final int textLength = semanticsLabel?.length ?? text!.length;
      collector.add(InlineSpanSemanticsInformation(
        text!,
        stringAttributes: <ui.StringAttribute>[
          if (effectiveSpellOut && textLength > 0)
            ui.SpellOutStringAttribute(
                range: TextRange(start: 0, end: textLength)),
          if (effectiveLocale != null && textLength > 0)
            ui.LocaleStringAttribute(
                locale: effectiveLocale,
                range: TextRange(start: 0, end: textLength)),
        ],
        semanticsLabel: semanticsLabel,
        recognizer: recognizer,
      ));
    }
    final List<InlineSpan>? children = this.children;
    if (children != null) {
      for (final InlineSpan child in children) {
        if (child is MTextSpan) {
          child.computeSemanticsInformation(
            collector,
            inheritedLocale: effectiveLocale,
            inheritedSpellOut: effectiveSpellOut,
          );
        } else {
          child.computeSemanticsInformation(collector);
        }
      }
    }
  }

  @override
  void computeToPlainText(
    StringBuffer buffer, {
    bool includeSemanticsLabels = true,
    bool includePlaceholders = true,
  }) {
    assert(debugAssertIsValid());
    if (semanticsLabel != null && includeSemanticsLabels) {
      buffer.write(semanticsLabel);
    } else if (text != null) {
      buffer.write(text);
    }
    if (children != null) {
      for (final InlineSpan child in children!) {
        child.computeToPlainText(
          buffer,
          includeSemanticsLabels: includeSemanticsLabels,
          includePlaceholders: includePlaceholders,
        );
      }
    }
  }

  @protected
  @override
  MouseCursor get cursor => mouseCursor;

  @override
  bool debugAssertIsValid() {
    assert(() {
      if (children != null) {
        for (final InlineSpan child in children!) {
          assert(child.debugAssertIsValid());
        }
      }
      return true;
    }());
    return super.debugAssertIsValid();
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return children?.map<DiagnosticsNode>((InlineSpan child) {
          return child.toDiagnosticsNode();
        }).toList() ??
        const <DiagnosticsNode>[];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      StringProperty(
        'text',
        text,
        showName: false,
        defaultValue: null,
      ),
    );
    if (style == null && text == null && children == null) {
      properties.add(DiagnosticsNode.message('(empty)'));
    }

    properties.add(DiagnosticsProperty<GestureRecognizer>(
      'recognizer',
      recognizer,
      description: recognizer?.runtimeType.toString(),
      defaultValue: null,
    ));

    properties.add(FlagsSummary<Function?>(
      'callbacks',
      <String, Function?>{
        'enter': onEnter,
        'exit': onExit,
      },
    ));
    properties.add(DiagnosticsProperty<MouseCursor>('mouseCursor', cursor,
        defaultValue: MouseCursor.defer));

    if (semanticsLabel != null) {
      properties.add(StringProperty('semanticsLabel', semanticsLabel));
    }
  }

  @override
  InlineSpan? getSpanForPositionVisitor(
      TextPosition position, Accumulator offset) {
    final String? text = this.text;
    if (text == null || text.isEmpty) {
      return null;
    }
    final TextAffinity affinity = position.affinity;
    final int targetOffset = position.offset;
    final int endOffset = offset.value + text.length;

    if (offset.value == targetOffset && affinity == TextAffinity.downstream ||
        offset.value < targetOffset && targetOffset < endOffset ||
        endOffset == targetOffset && affinity == TextAffinity.upstream) {
      return this;
    }
    offset.increment(text.length);
    return null;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      recognizer?.addPointer(event);
    }
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        text,
        recognizer,
        semanticsLabel,
        onEnter,
        onExit,
        mouseCursor,
        children == null ? null : Object.hashAll(children!),
      );

  @override
  TextStyle? get style =>
      super.style ??
      _defaultStyle(
        color: color,
        fontSize: fontSize,
        isBold: isBold,
        fontWeight: fontWeight,
        overflow: overflow,
      );

  @override
  String toStringShort() => objectRuntimeType(this, 'MTextSpan');

  @override
  bool get validForMouseTracker => true;

  @override
  bool visitChildren(InlineSpanVisitor visitor) {
    if (text != null && !visitor(this)) {
      return false;
    }
    final List<InlineSpan>? children = this.children;
    if (children != null) {
      for (final InlineSpan child in children) {
        if (!child.visitChildren(visitor)) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  bool visitDirectChildren(InlineSpanVisitor visitor) {
    final List<InlineSpan>? children = this.children;
    if (children != null) {
      for (final InlineSpan child in children) {
        if (!visitor(child)) {
          return false;
        }
      }
    }
    return true;
  }

  TextStyle? _defaultStyle({
    Color? color,
    double? fontSize,
    bool isBold = false,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }) {
    if (color != null || fontSize != null || isBold || fontWeight != null) {
      return TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight ?? (isBold ? FontWeight.bold : null),
        overflow: overflow,
      );
    }
    return null;
  }

  @override
  void build(
    ui.ParagraphBuilder builder, {
    TextScaler textScaler = TextScaler.noScaling,
    List<PlaceholderDimensions>? dimensions,
  }) {
    assert(debugAssertIsValid());
    final bool hasStyle = style != null;
    if (hasStyle) {
      builder.pushStyle(style!.getTextStyle(textScaler: textScaler));
    }
    if (text != null) {
      try {
        builder.addText(text!);
      } on ArgumentError catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'painting library',
          context: ErrorDescription('while building a MTextSpan'),
          silent: true,
        ));
        // Use a Unicode replacement character as a substitute for invalid text.
        builder.addText('\uFFFD');
      }
    }
    final List<InlineSpan>? children = this.children;
    if (children != null) {
      for (final InlineSpan child in children) {
        child.build(
          builder,
          textScaler: textScaler,
          dimensions: dimensions,
        );
      }
    }
    if (hasStyle) {
      builder.pop();
    }
  }
}
