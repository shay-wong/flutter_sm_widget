import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MButtonIconAlignment {
  start,
  top,
  end,
  bottom,
}

class MButton extends ButtonStyleButton {
  const MButton({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    super.isSemanticButton,
    required Widget super.child,
    this.backgroundColor,
    this.borderRadius,
    this.clearPadding = false,
    this.disabledColor,
    this.elevation,
    this.fixedSize,
    this.foregroundColor,
    this.maximumSize,
    this.minimumSize,
    this.noHighlight = false,
    this.noSplash = false,
    this.overlayColor,
    this.padding,
    this.radius,
    this.shadowColor,
    this.shape,
    this.side,
    this.splashFactory,
    this.tapTargetSize,
    this.textStyle,
    double? width,
    double? height,
    double? size,
  })  : width = width ?? size,
        height = height ?? size,
        isSelected = null;

  factory MButton.icon({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    MaterialStatesController? statesController,
    required Widget icon,
    Widget label,
    MButtonIconAlignment? alignment,
  }) = _MButtonWithIcon;

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? disabledColor;
  final double? elevation;
  final Color? foregroundColor;
  final double? height;
  final Size? maximumSize;
  final bool noHighlight;
  final bool noSplash;
  final double? radius;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final MaterialTapTargetSize? tapTargetSize;
  final TextStyle? textStyle;
  final double? width;

  /// 是否去除边距
  final bool clearPadding;

  /// 如果设置了 [fixedSize] 则 [width] 和 [height] 无效
  final Size? fixedSize;

  // TODO: 暂时无效
  /// 是否选中
  final bool? isSelected;

  // !!!: 注意使用
  // TODO: minimumSize 在手机浏览器上显示有问题!! 那么 maximumSize 呢?
  final Size? minimumSize;

  /// 如果设置了 [overlayColor] 则 [noHighlight] 无效
  final Color? overlayColor;

  /// 如果设置了 [padding] 则 [clearPadding] 无效
  final EdgeInsetsGeometry? padding;

  /// 如果设置了 [splashFactory] 则 [noSplash] 无效
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Theme.of(context).useMaterial3
        ? _MTextButtonDefaultsM3(
            context: context,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            clearPadding: clearPadding,
            disabledForegroundColor: disabledColor,
            elevation: elevation,
            fixedSize: fixedSize,
            foregroundColor: foregroundColor,
            height: height,
            maximumSize: maximumSize,
            minimumSize: minimumSize,
            noHighlight: noHighlight,
            noSplash: noSplash,
            overlayColor: overlayColor,
            padding: padding,
            radius: radius,
            shadowColor: shadowColor,
            shape: shape,
            side: side,
            splashFactory: splashFactory,
            tapTargetSize: tapTargetSize,
            textStyle: textStyle,
            width: width,
          )
        : _MTextButtonDefaultsM2(
            foregroundColor: foregroundColor ?? colorScheme.primary,
            disabledForegroundColor: disabledColor ?? colorScheme.onSurface.withOpacity(0.38),
            backgroundColor: backgroundColor ?? Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: shadowColor ?? theme.shadowColor,
            elevation: elevation ?? 0,
            textStyle: textStyle ?? theme.textTheme.labelLarge,
            padding: padding ?? (clearPadding ? EdgeInsets.zero : _scaledPadding(context)),
            minimumSize: minimumSize ?? (clearPadding ? Size.zero : const Size(64, 36)),
            maximumSize: maximumSize ?? Size.infinite,
            shape: shape ??
                RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 4))),
            enabledMouseCursor: SystemMouseCursors.click,
            disabledMouseCursor: SystemMouseCursors.basic,
            visualDensity: theme.visualDensity,
            tapTargetSize:
                tapTargetSize ?? (clearPadding ? MaterialTapTargetSize.shrinkWrap : theme.materialTapTargetSize),
            animationDuration: kThemeChangeDuration,
            enableFeedback: true,
            alignment: Alignment.center,
            splashFactory: splashFactory ?? (noSplash ? NoSplash.splashFactory : InkRipple.splashFactory),
            fixedSize: fixedSize ??
                (width != null || height != null ? Size(width ?? double.infinity, height ?? double.infinity) : null),
            noHighlighting: noHighlight,
            overlayColor: overlayColor,
            side: side,
          );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return TextButtonTheme.of(context).style;
  }

  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Color? iconColor,
    Color? disabledIconColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    Color? overlayColor,
  }) {
    final Color? foreground = foregroundColor;
    final Color? disabledForeground = disabledForegroundColor;
    final MaterialStateProperty<Color?>? foregroundColorProp = (foreground == null && disabledForeground == null)
        ? null
        : _MTextButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (backgroundColor == null && disabledBackgroundColor == null)
            ? null
            : disabledBackgroundColor == null
                ? ButtonStyleButton.allOrNull<Color?>(backgroundColor)
                : _MTextButtonDefaultColor(backgroundColor, disabledBackgroundColor);
    MaterialStateProperty<Color?>? effectiveOverlayColor =
        (overlayColor != null || foreground != null) ? _MTextButtonDefaultOverlay(overlayColor ?? foreground!) : null;
    final MaterialStateProperty<Color?>? iconColorProp = (iconColor == null && disabledIconColor == null)
        ? null
        : disabledIconColor == null
            ? ButtonStyleButton.allOrNull<Color?>(iconColor)
            : _MTextButtonDefaultIconColor(iconColor, disabledIconColor);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _TextButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
      foregroundColor: foregroundColorProp,
      backgroundColor: backgroundColorProp,
      overlayColor: effectiveOverlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      iconColor: iconColorProp,
      elevation: ButtonStyleButton.allOrNull<double>(elevation),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
}

class _MButtonWithIcon extends MButton {
  _MButtonWithIcon({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    Widget? label,
    MButtonIconAlignment? alignment,
  })  : alignment = alignment ?? MButtonIconAlignment.start,
        super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _MButtonWithIconChild(
            icon: icon,
            label: label,
            alignment: alignment ?? MButtonIconAlignment.start,
          ),
        );

  final MButtonIconAlignment alignment;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    final ButtonStyle buttonStyle = super.defaultStyleOf(context);
    final double defaultFontSize = buttonStyle.textStyle?.resolve(const <MaterialState>{})?.fontSize ?? 14.0;
    final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      useMaterial3
          ? alignment.isVertical
              ? const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 16)
              : const EdgeInsetsDirectional.fromSTEB(12, 8, 16, 8)
          : const EdgeInsets.all(8),
      alignment.isVertical ? const EdgeInsets.symmetric(vertical: 4) : const EdgeInsets.symmetric(horizontal: 4),
      alignment.isVertical ? const EdgeInsets.symmetric(vertical: 4) : const EdgeInsets.symmetric(horizontal: 4),
      effectiveTextScale,
    );
    return buttonStyle.copyWith(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

extension _MButtonIconAlignmentExt on MButtonIconAlignment {
  bool get isVertical {
    return this == MButtonIconAlignment.top || this == MButtonIconAlignment.bottom;
  }

  bool get isTerminus {
    return this == MButtonIconAlignment.end || this == MButtonIconAlignment.bottom;
  }
}

class _MButtonWithIconChild extends StatelessWidget {
  const _MButtonWithIconChild({
    this.label,
    required this.icon,
    this.alignment = MButtonIconAlignment.start,
  });

  final MButtonIconAlignment alignment;
  final Widget icon;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return icon;
    }
    // TODO: 删除弃用成员
    // ignore: deprecated_member_use
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    final gap = alignment.isVertical ? 6.0 : 8.0;
    final double effectiveGap = scale <= 1 ? gap : lerpDouble(gap, gap / 2, math.min(scale - 1, 1))!;
    final effectiveIcon = Flexible(child: icon);
    final effectiveSpace = alignment.isVertical ? SizedBox(height: effectiveGap) : SizedBox(width: effectiveGap);
    final effectiveLabel = Flexible(child: label!);

    List<Widget> children = <Widget>[
      effectiveIcon,
      effectiveSpace,
      effectiveLabel,
    ];
    if (alignment.isTerminus) {
      children = children.reversed.toList();
    }
    if (alignment.isVertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
  return ButtonStyleButton.scaledPadding(
    theme.useMaterial3 ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : const EdgeInsets.all(8),
    const EdgeInsets.symmetric(horizontal: 8),
    const EdgeInsets.symmetric(horizontal: 4),
    effectiveTextScale,
  );
}

@immutable
class _MTextButtonDefaultColor extends MaterialStateProperty<Color?> {
  _MTextButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }

  @override
  String toString() {
    return '{disabled: $disabled, otherwise: $color}';
  }
}

@immutable
class _MTextButtonDefaultIconColor extends MaterialStateProperty<Color?> {
  _MTextButtonDefaultIconColor(this.iconColor, this.disabledIconColor);

  final Color? disabledIconColor;
  final Color? iconColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledIconColor;
    }
    return iconColor;
  }

  @override
  String toString() {
    return '{disabled: $disabledIconColor, color: $iconColor}';
  }
}

@immutable
class _MTextButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _MTextButtonDefaultOverlay(this.primary);

  final Color primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return primary.withOpacity(0.12);
    }
    if (states.contains(MaterialState.hovered)) {
      return primary.withOpacity(0.04);
    }
    if (states.contains(MaterialState.focused)) {
      return primary.withOpacity(0.12);
    }
    return null;
  }

  @override
  String toString() {
    return '{hovered: ${primary.withOpacity(0.04)}, focused,pressed: ${primary.withOpacity(0.12)}, otherwise: null}';
  }
}

// ignore: non_constant_identifier_names
ButtonStyle _MTextButtonDefaultsM2({
  Color? foregroundColor,
  Color? backgroundColor,
  Color? disabledForegroundColor,
  Color? disabledBackgroundColor,
  Color? shadowColor,
  Color? surfaceTintColor,
  Color? iconColor,
  Color? disabledIconColor,
  double? elevation,
  TextStyle? textStyle,
  EdgeInsetsGeometry? padding,
  Size? minimumSize,
  Size? fixedSize,
  Size? maximumSize,
  BorderSide? side,
  OutlinedBorder? shape,
  MouseCursor? enabledMouseCursor,
  MouseCursor? disabledMouseCursor,
  VisualDensity? visualDensity,
  MaterialTapTargetSize? tapTargetSize,
  Duration? animationDuration,
  bool? enableFeedback,
  AlignmentGeometry? alignment,
  InteractiveInkFeatureFactory? splashFactory,
  bool noHighlighting = false,
  Color? overlayColor,
}) {
  final Color? foreground = foregroundColor;
  final Color? disabledForeground = disabledForegroundColor;
  final MaterialStateProperty<Color?>? foregroundColorProp = (foreground == null && disabledForeground == null)
      ? null
      : _MTextButtonDefaultColor(foreground, disabledForeground);
  final MaterialStateProperty<Color?>? backgroundColorProp =
      (backgroundColor == null && disabledBackgroundColor == null)
          ? null
          : disabledBackgroundColor == null
              ? ButtonStyleButton.allOrNull<Color?>(backgroundColor)
              : _MTextButtonDefaultColor(backgroundColor, disabledBackgroundColor);
  MaterialStateProperty<Color?>? effectiveOverlayColor;
  if (overlayColor != null) {
    effectiveOverlayColor = _MTextButtonDefaultOverlay(overlayColor);
  } else if (foreground != null && !noHighlighting) {
    effectiveOverlayColor = _MTextButtonDefaultOverlay(foreground);
  }
  final MaterialStateProperty<Color?>? iconColorProp = (iconColor == null && disabledIconColor == null)
      ? null
      : disabledIconColor == null
          ? ButtonStyleButton.allOrNull<Color?>(iconColor)
          : _MTextButtonDefaultIconColor(iconColor, disabledIconColor);
  final MaterialStateProperty<MouseCursor?> mouseCursor =
      _TextButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

  return ButtonStyle(
    textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
    foregroundColor: foregroundColorProp,
    backgroundColor: backgroundColorProp,
    overlayColor: effectiveOverlayColor,
    shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
    surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
    iconColor: iconColorProp,
    elevation: ButtonStyleButton.allOrNull<double>(elevation),
    padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
    minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
    fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
    maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
    side: ButtonStyleButton.allOrNull<BorderSide>(side),
    shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
    mouseCursor: mouseCursor,
    visualDensity: visualDensity,
    tapTargetSize: tapTargetSize,
    animationDuration: animationDuration,
    enableFeedback: enableFeedback,
    alignment: alignment,
    splashFactory: splashFactory,
  );
}

class _MTextButtonDefaultsM3 extends ButtonStyle {
  _MTextButtonDefaultsM3({
    required this.context,
    this.borderRadius,
    this.clearPadding = false,
    this.disabledForegroundColor,
    this.height,
    this.noHighlight = false,
    this.noSplash = false,
    this.radius,
    this.width,
    Color? backgroundColor,
    double? elevation,
    Size? fixedSize,
    Color? foregroundColor,
    Size? maximumSize,
    Size? minimumSize,
    Color? overlayColor,
    EdgeInsetsGeometry? padding,
    Color? shadowColor,
    OutlinedBorder? shape,
    BorderSide? side,
    InteractiveInkFeatureFactory? splashFactory,
    MaterialTapTargetSize? tapTargetSize,
    TextStyle? textStyle,
  })  : _backgroundColor = backgroundColor,
        _elevation = elevation,
        _fixedSize = fixedSize,
        _foregroundColor = foregroundColor,
        _maximumSize = maximumSize,
        _minimumSize = minimumSize,
        _overlayColor = overlayColor,
        _padding = padding,
        _shadowColor = shadowColor,
        _shape = shape,
        _side = side,
        _splashFactory = splashFactory,
        _tapTargetSize = tapTargetSize,
        _textStyle = textStyle,
        super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BorderRadius? borderRadius;
  final bool clearPadding;
  final BuildContext context;
  final Color? disabledForegroundColor;
  final double? height;
  final bool noHighlight;
  final bool noSplash;
  final double? radius;
  final double? width;

  final Color? _backgroundColor;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  final double? _elevation;
  final Size? _fixedSize;
  final Color? _foregroundColor;
  final Size? _maximumSize;
  final Size? _minimumSize;
  final Color? _overlayColor;
  final EdgeInsetsGeometry? _padding;
  final Color? _shadowColor;
  final OutlinedBorder? _shape;
  final BorderSide? _side;
  final InteractiveInkFeatureFactory? _splashFactory;
  final MaterialTapTargetSize? _tapTargetSize;
  final TextStyle? _textStyle;

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStatePropertyAll<Color>(_backgroundColor ?? Colors.transparent);

  @override
  MaterialStateProperty<double>? get elevation => MaterialStatePropertyAll<double>(_elevation ?? 0.0);

  // No default fixedSize
  @override
  MaterialStateProperty<Size?>? get fixedSize => _fixedSize != null || width != null || height != null
      ? MaterialStatePropertyAll<Size>(_fixedSize ?? Size(width ?? double.infinity, height ?? double.infinity))
      : null;

  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _foregroundColor ?? _colors.primary;
      });

  @override
  MaterialStateProperty<Size>? get maximumSize => MaterialStatePropertyAll<Size>(_maximumSize ?? Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      MaterialStatePropertyAll<Size>(_minimumSize ?? (clearPadding ? Size.zero : const Size(64.0, 40.0)));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor => _overlayColor == null && noHighlight
      ? null
      : MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return (_overlayColor ?? _colors.primary).withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return (_overlayColor ?? _colors.primary).withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return (_overlayColor ?? _colors.primary).withOpacity(0.12);
          }
          return null;
        });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding => MaterialStatePropertyAll<EdgeInsetsGeometry>(
      _padding ?? (clearPadding ? EdgeInsets.zero : _scaledPadding(context)));

  @override
  MaterialStateProperty<Color>? get shadowColor => MaterialStatePropertyAll<Color>(_shadowColor ?? Colors.transparent);

  @override
  MaterialStateProperty<OutlinedBorder>? get shape => MaterialStatePropertyAll<OutlinedBorder>(
        _shape ??
            (radius == null && borderRadius == null
                ? const StadiumBorder()
                : RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 4.0)),
                  )),
      );

  // No default side
  @override
  MaterialStateProperty<BorderSide?>? get side => _side == null ? null : MaterialStatePropertyAll<BorderSide>(_side);

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      _splashFactory ?? (noSplash ? NoSplash.splashFactory : Theme.of(context).splashFactory);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      _tapTargetSize ?? (clearPadding ? MaterialTapTargetSize.shrinkWrap : Theme.of(context).materialTapTargetSize);

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
      MaterialStatePropertyAll<TextStyle?>(_textStyle ?? Theme.of(context).textTheme.labelLarge);

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;
}

@immutable
class _TextButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _TextButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor? disabledCursor;
  final MouseCursor? enabledCursor;

  @override
  MouseCursor? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}
