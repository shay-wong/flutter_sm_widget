import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'm_text_style.dart';

@immutable
class MTextSpan extends TextSpan {
  const MTextSpan({
    super.text,
    super.children,
    super.style,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.overflow,
    this.decoration,
    this.foreground,
    this.shadows,
    this.isBold = false,
    this.isItalic = false,
    this.isDeleted = false,
  }) : super();

  final Color? color;
  final TextDecoration? decoration;
  final String? fontFamily;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Paint? foreground;
  final bool isBold;
  final bool isDeleted;
  final bool isItalic;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  @override
  TextStyle? get style => super.style ?? _defaultStyle;

  @override
  String toStringShort() => objectRuntimeType(this, 'MTextSpan');

  TextStyle? get _defaultStyle {
    if (color != null ||
        fontSize != null ||
        fontWeight != null ||
        fontFamily != null ||
        fontStyle != null ||
        isBold ||
        isItalic ||
        isDeleted ||
        overflow != null ||
        decoration != null ||
        foreground != null ||
        shadows != null) {
      return MTextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        isBold: isBold,
        isItalic: isItalic,
        overflow: overflow,
        decoration: decoration,
        isDeleted: isDeleted,
        foreground: foreground,
        shadows: shadows,
      );
    }
    return null;
  }
}
