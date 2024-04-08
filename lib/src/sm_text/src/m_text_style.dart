// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/painting.dart';

const String _kColorBackgroundWarning = 'Cannot provide both a backgroundColor and a background\n'
    'The backgroundColor argument is just a shorthand for "background: Paint()..color = color".';

const String _kColorForegroundWarning = 'Cannot provide both a color and a foreground\n'
    'The color argument is just a shorthand for "foreground: Paint()..color = color".';

const String _kDefaultDebugLabel = 'unknown';

class MStrutStyle extends StrutStyle {
  const MStrutStyle({
    super.fontFamily,
    super.fontFamilyFallback,
    super.fontSize,
    double? height,
    this.lineHeight,
    super.leadingDistribution,
    super.leading,
    super.fontWeight,
    super.fontStyle,
    super.forceStrutHeight,
    super.debugLabel,
    super.package,
  }) : super(height: height ?? (lineHeight != null && fontSize != null ? lineHeight / fontSize : null));

  /// [StrutStyle.height] 文本段落行高, 自动除以 [fontSize] 来计算, 如果设置 [height] 则会忽略此值.
  /// 如果传递给 [MText] 会除以默认的 [fontSize],
  /// 如果传递给 [Text] 则必须设置 [fontSize], 否则不生效.
  final double? lineHeight;

  MStrutStyle copyWith({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    double? height,
    double? lineHeight,
    TextLeadingDistribution? leadingDistribution,
    double? leading,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool? forceStrutHeight,
    String? debugLabel,
  }) {
    return MStrutStyle(
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      height: height ?? this.height,
      lineHeight: lineHeight ?? this.lineHeight,
      leadingDistribution: leadingDistribution ?? this.leadingDistribution,
      leading: leading ?? this.leading,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      forceStrutHeight: forceStrutHeight ?? this.forceStrutHeight,
      debugLabel: debugLabel ?? this.debugLabel,
    );
  }
}

class MTextStyle extends TextStyle {
  const MTextStyle({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    double? height,
    this.lineHeight,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    TextDecoration? decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.overflow,
    bool isBold = false,
    bool isDeleted = false,
    bool isItalic = false,
  }) : super(
          height: height ?? (lineHeight != null && fontSize != null ? lineHeight / fontSize : null),
          fontWeight: fontWeight ?? (isBold ? FontWeight.bold : null),
          fontStyle: fontStyle ?? (isItalic ? FontStyle.italic : null),
          decoration: decoration ??
              (isDeleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none), // 默认 TextDecoration.none 是为了去除没有Scaffold 或者 material 时的文本下黄线
        );

  /// [TextStyle.height] 文本行高, 自动除以 [fontSize] 来计算, 如果设置 [height] 则会忽略此值.
  /// 如果传递给 [MText] 会除以默认的 [fontSize],
  /// 如果传递给 [Text] 则必须设置 [fontSize], 否则不生效.
  final double? lineHeight;
}

extension MFontWeight on FontWeight {
  static const FontWeight thin = FontWeight.w300;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight exteraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

extension TextStyleEx on TextStyle {
  /// 返回此 [TextStyle] 的副本，其中 [other] 中的非空字段替换了此 [TextStyle] 中相应的空字段。
  /// 换句话说，[other] 用于填充此 [TextStyle] 中的未指定（空）字段。
  /// !!!: [_package] 字段是私有的，无法获取 [package], 所以不能替换 package 字段。
  TextStyle combine(TextStyle? other) {
    if (other == null) {
      return this;
    }
    if (!other.inherit) {
      return other;
    }

    String? combinedDebugLabel;
    assert(() {
      if (other.debugLabel != null || debugLabel != null) {
        combinedDebugLabel =
            '(${debugLabel ?? _kDefaultDebugLabel}).combine(${other.debugLabel ?? _kDefaultDebugLabel})';
      }
      return true;
    }());

    return copyWith(
      color: color ?? other.color,
      backgroundColor: backgroundColor ?? other.backgroundColor,
      fontSize: fontSize ?? other.fontSize,
      fontWeight: fontWeight ?? other.fontWeight,
      fontStyle: fontStyle ?? other.fontStyle,
      letterSpacing: letterSpacing ?? other.letterSpacing,
      wordSpacing: wordSpacing ?? other.wordSpacing,
      textBaseline: textBaseline ?? other.textBaseline,
      height: height ?? other.height,
      leadingDistribution: leadingDistribution ?? other.leadingDistribution,
      locale: locale ?? other.locale,
      foreground: foreground ?? other.foreground,
      background: background ?? other.background,
      shadows: shadows ?? other.shadows,
      fontFeatures: fontFeatures ?? other.fontFeatures,
      fontVariations: fontVariations ?? other.fontVariations,
      decoration: decoration ?? other.decoration,
      decorationColor: decorationColor ?? other.decorationColor,
      decorationStyle: decorationStyle ?? other.decorationStyle,
      decorationThickness: decorationThickness ?? other.decorationThickness,
      debugLabel: debugLabel ?? combinedDebugLabel,
      fontFamily: fontFamily ?? other.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? other.fontFamilyFallback,
      overflow: overflow ?? other.overflow,
    );
  }

  /// 返回此 [TextStyle] 的副本，其中 [other] 中的非空字段替换了此 [TextStyle] 中相应的空字段。
  /// 换句话说，[other] 用于填充此 [TextStyle] 中的未指定（空）字段。
  /// !!!: [_package] 字段是私有的，无法获取 [package], 所以会直接替换 package 字段。
  TextStyle combineWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    assert(color == null || foreground == null, _kColorForegroundWarning);
    assert(backgroundColor == null || background == null, _kColorBackgroundWarning);
    String? newDebugLabel;
    assert(() {
      if (this.debugLabel != null) {
        newDebugLabel = debugLabel ?? '(${this.debugLabel}).combineWith';
      }
      return true;
    }());

    return copyWith(
      color: this.color ?? color,
      backgroundColor: this.backgroundColor ?? backgroundColor,
      fontSize: this.fontSize ?? fontSize,
      fontWeight: this.fontWeight ?? fontWeight,
      fontStyle: this.fontStyle ?? fontStyle,
      letterSpacing: this.letterSpacing ?? letterSpacing,
      wordSpacing: this.wordSpacing ?? wordSpacing,
      textBaseline: this.textBaseline ?? textBaseline,
      height: this.height ?? height,
      leadingDistribution: this.leadingDistribution ?? leadingDistribution,
      locale: this.locale ?? locale,
      foreground: this.foreground ?? foreground,
      background: this.background ?? background,
      shadows: this.shadows ?? shadows,
      fontFeatures: this.fontFeatures ?? fontFeatures,
      fontVariations: this.fontVariations ?? fontVariations,
      decoration: this.decoration ?? decoration,
      decorationColor: this.decorationColor ?? decorationColor,
      decorationStyle: this.decorationStyle ?? decorationStyle,
      decorationThickness: this.decorationThickness ?? decorationThickness,
      debugLabel: newDebugLabel ?? debugLabel,
      fontFamily: this.fontFamily ?? fontFamily,
      fontFamilyFallback: this.fontFamilyFallback ?? fontFamilyFallback,
      overflow: this.overflow ?? overflow,
      package: package,
    );
  }
}
