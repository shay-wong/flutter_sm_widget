import 'package:extended_text/extended_text.dart';
import 'package:flutter/rendering.dart';

import 'm_text_span.dart';

class MRichText extends ExtendedRichText {
  MRichText({
    super.key,
    required super.text,
    super.textAlign,
    super.textDirection,
    super.softWrap = true,
    super.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    double textScaleFactor = 1.0,
    TextScaler textScaler = TextScaler.noScaling,
    super.maxLines,
    super.locale,
    StrutStyle? strutStyle,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionRegistrar,
    super.selectionColor,
    super.overflowWidget,
    super.canSelectPlaceholderSpan = true,
    TextStyle? style,
    String? fontFamily,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? fontSize,
    bool isBold = false,
    bool isItalic = false,
    bool isDeleted = false,
    Paint? foreground,
    List<Shadow>? shadows,
    bool? forceStrutHeight,
  })  : assert(
            textScaleFactor == 1.0 ||
                identical(textScaler, TextScaler.noScaling),
            'Use textScaler instead.'),
        super(
          textScaler: _effectiveTextScalerFrom(textScaler, textScaleFactor),
          strutStyle: strutStyle ??
              _strutStyle(
                forceStrutHeight,
              ),
        );

  /// Creates a rich text widget from a list of [InlineSpan] objects
  /// 根据子项创建富文本
  MRichText.children({
    super.key,
    super.textAlign,
    super.textDirection,
    super.softWrap = true,
    super.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    double textScaleFactor = 1.0,
    TextScaler textScaler = TextScaler.noScaling,
    super.maxLines,
    super.locale,
    StrutStyle? strutStyle,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionRegistrar,
    super.selectionColor,
    super.overflowWidget,
    super.canSelectPlaceholderSpan = true,
    required List<InlineSpan> children,
    TextStyle? style,
    String? fontFamily,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? fontSize,
    bool isBold = false,
    bool isItalic = false,
    bool isDeleted = false,
    Paint? foreground,
    List<Shadow>? shadows,
    bool? forceStrutHeight,
  })  : assert(
            textScaleFactor == 1.0 ||
                identical(textScaler, TextScaler.noScaling),
            'Use textScaler instead.'),
        super(
          text: MTextSpan(
            children: children,
            style: style,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            fontSize: fontSize,
            isBold: isBold,
            isItalic: isItalic,
            isDeleted: isDeleted,
            foreground: foreground,
            shadows: shadows,
          ),
          textScaler: _effectiveTextScalerFrom(textScaler, textScaleFactor),
          strutStyle: strutStyle ??
              _strutStyle(
                forceStrutHeight,
              ),
        );

  static TextScaler _effectiveTextScalerFrom(
      TextScaler textScaler, double textScaleFactor) {
    return switch ((textScaler, textScaleFactor)) {
      (final TextScaler scaler, 1.0) => scaler,
      (TextScaler.noScaling, final double textScaleFactor) =>
        TextScaler.linear(textScaleFactor),
      (final TextScaler scaler, _) => scaler,
    };
  }

  /// [TextScaler.noScaling] 导致 [Text] 和 [RichText] 设置相同 [fontSize] 显示大小不一致,
  /// [Text] 默认不是 [TextScaler.noScaling], 但是如果 [Text] 设置了 [TextScaler.noScaling],
  /// 在 Material 3 下还是会有细微的宽度差别, 宽高都会更大一点, 应该是有其他影响到了(猜测可能是有内边距?),
  /// 暂时没找到原因, 后面在看看.
  // final TextScaler textScaler;

  static StrutStyle? _strutStyle(
    bool? forceStrutHeight,
  ) {
    if (forceStrutHeight == null) {
      return null;
    }
    return StrutStyle(forceStrutHeight: forceStrutHeight);
  }
}
