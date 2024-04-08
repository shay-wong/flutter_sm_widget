// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:ui' as ui show TextHeightBehavior;

import 'package:extended_text/extended_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sm_widget/src/sm_text/src/m_text_style.dart';

import 'm_rich_text.dart';
import 'm_text_span.dart';

class MText extends StatelessWidget {
  const MText(
    this.data, {
    super.key,
    this.color,
    this.decoration,
    this.fontFamily,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.forceStrutHeight,
    this.foreground,
    this.isBold = false,
    this.isDeleted = false,
    this.isItalic = false,
    this.height,
    this.lineHeight,
    this.strutHeight,
    this.strutLineHeight,
    this.locale,
    this.maxLines,
    this.overflow,
    this.selectionColor,
    this.semanticsLabel,
    this.shadows,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    this.textScaleFactor,
    this.textScaler,
    this.textWidthBasis,
    this.joinZeroWidthSpace = false,
    this.onSpecialTextTap,
    this.overflowWidget,
    this.specialTextSpanBuilder,
    this.canSelectPlaceholderSpan = true,
  })  : textSpan = null,
        children = null,
        assert(
          textScaler == null || textScaleFactor == null,
          'textScaleFactor is deprecated and cannot be specified when textScaler is specified.',
        );

  const MText.rich({
    super.key,
    InlineSpan? text,
    this.children,
    this.color,
    this.decoration,
    this.fontFamily,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.forceStrutHeight = false,
    this.foreground,
    this.isBold = false,
    this.isDeleted = false,
    this.isItalic = false,
    this.height,
    this.lineHeight,
    this.strutHeight,
    this.strutLineHeight,
    this.locale,
    this.maxLines,
    this.overflow,
    this.selectionColor,
    this.semanticsLabel,
    this.shadows,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    this.textScaleFactor,
    this.textScaler,
    this.textWidthBasis,
    this.joinZeroWidthSpace = false,
    this.onSpecialTextTap,
    this.overflowWidget,
    this.specialTextSpanBuilder,
    this.canSelectPlaceholderSpan = true,
  })  : assert(text == null || children == null),
        textSpan = text,
        data = null,
        assert(
          textScaler == null || textScaleFactor == null,
          'textScaleFactor is deprecated and cannot be specified when textScaler is specified.',
        );

  final TextDecoration? decoration;
  final Locale? locale;
  final Color? selectionColor;
  final String? semanticsLabel;
  final List<Shadow>? shadows;
  final bool? softWrap;
  final ui.TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;

  /// if false, it will skip PlaceholderSpan
  final bool canSelectPlaceholderSpan;

  /// 文本片段集合
  final List<InlineSpan>? children;

  /// 文本颜色
  final Color? color;

  /// 文本内容
  final String? data;

  /// 字体
  final String? fontFamily;

  /// 字体大小
  final double? fontSize;

  /// 字体风格
  final FontStyle? fontStyle;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 是否强制使用高度
  final bool? forceStrutHeight;

  /// 前景
  final Paint? foreground;

  /// [TextStyle.height] 文本的最小高度，是对应 [fontSize] 的倍数。
  final double? height;

  /// 是否加粗
  final bool isBold;

  /// 是否显示删除线
  final bool isDeleted;

  /// 是否斜体
  final bool isItalic;

  /// Whether join '\u{200B}' into text
  /// https://github.com/flutter/flutter/issues/18761#issuecomment-812390920
  ///
  /// Characters(text).join('\u{200B}')
  ///
  final bool joinZeroWidthSpace;

  /// [TextStyle.height] 行高, 自动除以 [fontSize] 来计算, 如果设置 [height] 则会忽略此值.
  final double? lineHeight;

  /// 文本最大行数
  final int? maxLines;

  /// call back of SpecialText tap
  final SpecialTextGestureTapCallback? onSpecialTextTap;

  /// 文本溢出模式
  final TextOverflow? overflow;

  /// maxheight is equal to textPainter.preferredLineHeight
  /// maxWidth is equal to textPainter.width
  final TextOverflowWidget? overflowWidget;

  /// build your ccustom text span
  final SpecialTextSpanBuilder? specialTextSpanBuilder;

  /// [StrutStyle.height] 文本段落最小行高，是对应 [fontSize] 的倍数。
  final double? strutHeight;

  /// [StrutStyle.height] 文本段落最小行高, 自动除以 [fontSize] 来计算, 如果设置 [strutHeight] 则会忽略此值.
  final double? strutLineHeight;

  /// 文本支撑样式, 定义文本的垂直布局属性
  final StrutStyle? strutStyle;

  /// 文本样式
  final TextStyle? style;

  /// 文本对齐
  final TextAlign? textAlign;

  /// 文本方向
  final TextDirection? textDirection;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  /// 文本缩放
  final TextScaler? textScaler;

  /// 文本片段
  final InlineSpan? textSpan;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('data', data, showName: false));
    if (textSpan != null) {
      properties.add(textSpan!.toDiagnosticsNode(name: 'textSpan', style: DiagnosticsTreeStyle.transition));
    }
    style?.debugFillProperties(properties);
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
    properties.add(FlagProperty('softWrap',
        value: softWrap,
        ifTrue: 'wrapping at box width',
        ifFalse: 'no wrapping except at line break characters',
        showName: true));
    properties.add(EnumProperty<TextOverflow>('overflow', overflow, defaultValue: null));
    properties.add(DoubleProperty('textScaleFactor', textScaleFactor, defaultValue: null));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: null));
    properties.add(EnumProperty<TextWidthBasis>('textWidthBasis', textWidthBasis, defaultValue: null));
    properties
        .add(DiagnosticsProperty<ui.TextHeightBehavior>('textHeightBehavior', textHeightBehavior, defaultValue: null));
    if (semanticsLabel != null) {
      properties.add(StringProperty('semanticsLabel', semanticsLabel));
    }
  }

  InlineSpan _buildTextSpan(TextStyle? effectiveTextStyle) {
    InlineSpan? innerTextSpan = specialTextSpanBuilder?.build(
      data!,
      textStyle: effectiveTextStyle,
      onTap: onSpecialTextTap,
    );

    innerTextSpan ??= MTextSpan(
      style: effectiveTextStyle,
      text: data,
      children: textSpan != null ? <InlineSpan>[textSpan!] : children,
    );

    if (joinZeroWidthSpace) {
      innerTextSpan = ExtendedTextLibraryUtils.joinChar(
        innerTextSpan,
        Accumulator(),
        ExtendedTextLibraryUtils.zeroWidthSpace,
      );
    }

    return innerTextSpan;
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
      if (style is MTextStyle) {
        final mStyle = style as MTextStyle;
        effectiveTextStyle = defaultTextStyle.style.merge(
          mStyle.copyWith(
            height: mStyle.height ??
                (mStyle.lineHeight != null && defaultTextStyle.style.fontSize != null
                    ? mStyle.lineHeight! / defaultTextStyle.style.fontSize!
                    : null),
          ),
        );
      }
    }
    if (style == null) {
      effectiveTextStyle = effectiveTextStyle?.copyWith(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight ?? (isBold ? FontWeight.bold : null),
        fontStyle: fontStyle ?? (isItalic ? FontStyle.italic : null),
        decoration: decoration ??
            (isDeleted
                ? TextDecoration.lineThrough
                : TextDecoration.none), // 默认 TextDecoration.none 是为了去除没有Scaffold 或者 material 时的文本下黄线
        foreground: foreground,
        shadows: shadows,
        height: height ??
            (lineHeight != null && effectiveTextStyle.fontSize != null
                ? lineHeight! / effectiveTextStyle.fontSize!
                : null),
      );
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    final TextScaler textScaler = switch ((this.textScaler, textScaleFactor)) {
      (final TextScaler textScaler, _) => textScaler,
      // For unmigrated apps, fall back to textScaleFactor.
      (null, final double textScaleFactor) => TextScaler.linear(textScaleFactor),
      (null, null) => MediaQuery.textScalerOf(context),
    };

    StrutStyle? effectiveStrutStyle = strutStyle;
    if (strutStyle is MStrutStyle) {
      final mStrutStyle = strutStyle as MStrutStyle;
      effectiveStrutStyle = mStrutStyle.copyWith(
        height: mStrutStyle.height ??
            (mStrutStyle.lineHeight != null && defaultTextStyle.style.fontSize != null
                ? mStrutStyle.lineHeight! / defaultTextStyle.style.fontSize!
                : null),
      );
    }
    if (strutStyle == null && forceStrutHeight != null || strutHeight != null || strutLineHeight != null) {
      effectiveStrutStyle = StrutStyle.fromTextStyle(
        effectiveTextStyle!,
        height: strutHeight ??
            (strutLineHeight != null && effectiveTextStyle.fontSize != null
                ? strutLineHeight! / effectiveTextStyle.fontSize!
                : null),
        forceStrutHeight: forceStrutHeight,
      );
    }

    // 当 [overflow] 为空 [maxLines] 不为空时, 默认使用 [TextOverflow.ellipsis]
    final finalOverflow = overflow ??
        (maxLines != null ? TextOverflow.ellipsis : null) ??
        effectiveTextStyle?.overflow ??
        defaultTextStyle.overflow;

    Widget result = MRichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection, // RichText uses Directionality.of to obtain a default if this is null.
      locale: locale, // RichText uses Localizations.localeOf to obtain a default if this is null
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: finalOverflow,
      textScaler: textScaler,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      strutStyle: effectiveStrutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior:
          textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
      selectionRegistrar: registrar,
      selectionColor:
          selectionColor ?? DefaultSelectionStyle.of(context).selectionColor ?? DefaultSelectionStyle.defaultColor,
      text: _buildTextSpan(effectiveTextStyle),
      overflowWidget: overflowWidget,
      canSelectPlaceholderSpan: canSelectPlaceholderSpan,
    );
    if (registrar != null) {
      result = MouseRegion(
        cursor: DefaultSelectionStyle.of(context).mouseCursor ?? SystemMouseCursors.text,
        child: result,
      );
    }
    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}

extension MTextToSpanExt on MText {
  InlineSpan get toSpan {
    return WidgetSpan(child: this);
  }

  TextSpan get toTextSpan {
    return TextSpan(
      text: data,
      style: style ??
          TextStyle(
            fontSize: fontSize ?? 14,
            color: color ?? const Color(0xFF333333),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
      children: textSpan != null ? <InlineSpan>[textSpan!] : null,
    );
  }
}
