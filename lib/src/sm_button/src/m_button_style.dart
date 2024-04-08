import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sm_logger/sm_logger.dart';

enum MButtonMode {
  text,
  textIcon,
  iconStandard,
  iconFilled,
  iconTonal,
  iconOutlined,
  filled,
  tonal,
  outlined,
  outlinedIcon,
  elevated,
}

extension _MButtonModeExt on MButtonMode {
  bool get isIconButton =>
      this == MButtonMode.iconStandard ||
      this == MButtonMode.iconFilled ||
      this == MButtonMode.iconTonal ||
      this == MButtonMode.iconOutlined;
}

@immutable
class _MButtonDefaultColor extends MaterialStateProperty<Color?> {
  _MButtonDefaultColor(
    this.color,
    this.disabled,
    this.unselected,
    this.selected,
    this.selectedDisabled,
    this.toggleable,
  );

  final Color? color;
  final Color? disabled;
  final Color? selected;
  final Color? selectedDisabled;
  final bool toggleable;
  final Color? unselected;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      if (states.contains(MaterialState.disabled)) {
        return selectedDisabled ?? disabled;
      }
      return selected;
    }
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    if (toggleable) {
      // toggleable but unselected case
      return unselected;
    }
    return color;
  }

  @override
  String toString() {
    return '{disabled: $disabled, otherwise: $color}';
  }
}

@immutable
class _MButtonDefaultIconColor extends MaterialStateProperty<Color?> {
  _MButtonDefaultIconColor(this.iconColor, this.disabledIconColor);

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
class _MButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor?>
    with Diagnosticable {
  _MButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

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

@immutable
class _MButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _MButtonDefaultOverlay(
    this.primary,
    this.focus,
    this.hover,
    this.highlight,
    this.disable,
    this.unselectedPrimary,
    this.unselectedFocus,
    this.unselectedHover,
    this.unselectedHighlight,
    this.unselectedDisable,
    this.selectedPrimary,
    this.selectedFocus,
    this.selectedHover,
    this.selectedHighlight,
    this.selectedDisable,
    this.noOverlay,
    this.toggleable,
    this.useMaterial3,
    this.mode,
  );

  final Color? disable;
  final Color? focus;
  final Color? highlight;
  final Color? hover;
  final MButtonMode mode;
  final bool noOverlay;
  final Color? primary;
  final Color? selectedDisable;
  final Color? selectedFocus;
  final Color? selectedHighlight;
  final Color? selectedHover;
  final Color? selectedPrimary;
  final bool toggleable;
  final Color? unselectedDisable;
  final Color? unselectedFocus;
  final Color? unselectedHighlight;
  final Color? unselectedHover;
  final Color? unselectedPrimary;
  final bool useMaterial3;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (noOverlay) {
      return Colors.transparent;
    }

    final pressedOrFocusedOpacity = mode == MButtonMode.elevated ? 0.24 : 0.12;
    final hoveredOpacity = useMaterial3 ? 0.08 : 0.04;

    if (states.contains(MaterialState.selected)) {
      if (states.contains(MaterialState.pressed)) {
        return selectedHighlight ??
            primary?.withOpacity(pressedOrFocusedOpacity);
      }
      if (states.contains(MaterialState.hovered)) {
        return selectedHover ?? primary?.withOpacity(hoveredOpacity);
      }
      if (states.contains(MaterialState.focused)) {
        return selectedFocus ?? primary?.withOpacity(pressedOrFocusedOpacity);
      }
      if (states.contains(MaterialState.disabled)) {
        return selectedDisable;
      }
    }
    if (toggleable) {
      // toggleable but unselected case
      if (states.contains(MaterialState.pressed)) {
        return unselectedHighlight ??
            unselectedPrimary?.withOpacity(pressedOrFocusedOpacity);
      }
      if (states.contains(MaterialState.hovered)) {
        return unselectedHover ??
            unselectedPrimary?.withOpacity(hoveredOpacity);
      }
      if (states.contains(MaterialState.focused)) {
        return unselectedFocus ??
            unselectedPrimary?.withOpacity(pressedOrFocusedOpacity);
      }
      if (states.contains(MaterialState.disabled)) {
        return unselectedDisable;
      }
    }

    if (states.contains(MaterialState.pressed)) {
      return highlight ?? primary?.withOpacity(pressedOrFocusedOpacity);
    }
    if (states.contains(MaterialState.hovered)) {
      return hover ?? primary?.withOpacity(hoveredOpacity);
    }
    if (states.contains(MaterialState.focused)) {
      return focus ?? primary?.withOpacity(pressedOrFocusedOpacity);
    }
    if (states.contains(MaterialState.disabled)) {
      return disable;
    }

    return mode.isIconButton ? Colors.transparent : null;
  }

  @override
  String toString() {
    final pressedOrFocusedOpacity = mode == MButtonMode.elevated ? 0.24 : 0.12;
    final hoveredOpacity = useMaterial3 ? 0.08 : 0.04;
    return '{hovered: ${hover ?? primary?.withOpacity(hoveredOpacity)}, focused: ${focus ?? primary?.withOpacity(pressedOrFocusedOpacity)}, pressed: ${highlight ?? primary?.withOpacity(pressedOrFocusedOpacity)}, disabled: $disable, otherwise: null}';
  }
}

class MButtonStyle extends ButtonStyle {
  const MButtonStyle({
    super.textStyle,
    super.backgroundColor,
    super.foregroundColor,
    super.overlayColor,
    super.shadowColor,
    super.surfaceTintColor,
    super.elevation,
    super.padding,
    super.minimumSize,
    super.fixedSize,
    super.maximumSize,
    super.iconColor,
    super.iconSize,
    super.side,
    super.shape,
    super.mouseCursor,
    super.visualDensity,
    super.tapTargetSize,
    super.animationDuration,
    super.enableFeedback,
    super.alignment,
    super.splashFactory,
  });

  /// [maximumSize] 最大尺寸
  /// !!!: 注意 [IconButton] 在 [Material 3] 下 [minimumSize] 默认为 40x40.
  /// !!!: 如果设置了 [maximumSize] 不设置 [minimumSize], 并且 [maximumSize] 小于 [minimumSize], 则会导致约束冲突.
  /// BoxConstraints has both width and height constraints non-normalized.
  // final MaterialStateProperty<Size?>? maximumSize;

  factory MButtonStyle.from({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? unselectedForegroundColor,
    Color? unselectedBackgroundColor,
    Color? selectedForegroundColor,
    Color? selectedBackgroundColor,
    Color? selectedDisabledForegroundColor,
    Color? selectedDisabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Color? iconColor,
    double? iconSize,
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
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    Color? overlayColor,
    Color? overlayFocusColor,
    Color? overlayHighlightColor,
    Color? overlayHoverColor,
    Color? overlayDisabledColor,
    Color? overlayUnselectedColor,
    Color? overlayUnselectedFocusColor,
    Color? overlayUnselectedHighlightColor,
    Color? overlayUnselectedHoverColor,
    Color? overlayUnselectedDisabledColor,
    Color? overlaySelectedColor,
    Color? overlaySelectedFocusColor,
    Color? overlaySelectedHighlightColor,
    Color? overlaySelectedHoverColor,
    Color? overlaySelectedDisabledColor,
    bool? noOverlay,
    bool? noSplash,
    double? width,
    double? height,
    double? size,
    bool? isSelected,
    bool? useMaterial3,
    MButtonMode? mode,
  }) {
    final currentMode = mode ?? MButtonMode.text;
    final clears = clearPadding ?? false;
    final toggleable = isSelected != null;

    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foregroundColor == null && disabledForegroundColor == null)
            ? null
            : _MButtonDefaultColor(
                foregroundColor,
                disabledForegroundColor,
                unselectedForegroundColor,
                selectedForegroundColor,
                selectedDisabledForegroundColor,
                toggleable,
              );

    final MaterialStateProperty<Color?>? backgroundColorProp =
        (backgroundColor == null && disabledBackgroundColor == null)
            ? null
            : _MButtonDefaultColor(
                backgroundColor,
                disabledBackgroundColor,
                unselectedBackgroundColor,
                selectedBackgroundColor,
                selectedDisabledBackgroundColor,
                toggleable,
              );

    final overlaySetting = overlayColor == null &&
        overlayFocusColor == null &&
        overlayHighlightColor == null &&
        overlayHoverColor == null &&
        overlayDisabledColor == null &&
        overlayUnselectedColor == null &&
        overlayUnselectedFocusColor == null &&
        overlayUnselectedHighlightColor == null &&
        overlayUnselectedHoverColor == null &&
        overlayUnselectedDisabledColor == null &&
        overlaySelectedColor == null &&
        overlaySelectedFocusColor == null &&
        overlaySelectedHighlightColor == null &&
        overlaySelectedHoverColor == null &&
        overlaySelectedDisabledColor == null;

    final effectiveOverlayColor = overlaySetting && noOverlay == null
        ? null
        : _MButtonDefaultOverlay(
            overlayColor ?? foregroundColor,
            overlayFocusColor,
            overlayHoverColor,
            overlayHighlightColor,
            overlayDisabledColor,
            overlayUnselectedColor,
            overlayUnselectedFocusColor,
            overlayUnselectedHoverColor,
            overlayUnselectedHighlightColor,
            overlayUnselectedDisabledColor,
            overlaySelectedColor,
            overlaySelectedFocusColor,
            overlaySelectedHoverColor,
            overlaySelectedHighlightColor,
            overlaySelectedDisabledColor,
            noOverlay != null && noOverlay && overlaySetting,
            toggleable,
            useMaterial3 ?? true,
            currentMode,
          );
    if (noOverlay != null && noOverlay && !overlaySetting) {
      logger.w('overlayColors is not null, noOverlay will be ignored');
    }

    final MaterialStateProperty<Color?>? iconColorProp =
        (iconColor == null && disabledIconColor == null)
            ? null
            : _MButtonDefaultIconColor(iconColor, disabledIconColor);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _MButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

    final MaterialStateProperty<double>? elevationValue = (elevation == null)
        ? null
        : currentMode == MButtonMode.elevated
            ? _MElevatedButtonDefaultElevation(elevation)
            : ButtonStyleButton.allOrNull<double>(elevation);

    final effectivePadding = padding ?? (clears ? EdgeInsets.zero : null);
    final effectiveMinimumSize = minimumSize ?? (clears ? Size.zero : null);
    final effectiveTapTargetSize =
        tapTargetSize ?? (clears ? MaterialTapTargetSize.shrinkWrap : null);

    final effectiveWidth = width ?? size;
    final effectiveHeight = height ?? size;
    final Size? effectiveSize = fixedSize ??
        (effectiveWidth != null || effectiveHeight != null
            ? Size(effectiveWidth ?? double.infinity,
                effectiveHeight ?? double.infinity)
            : null);
    final OutlinedBorder? effectiveShape = shape ??
        (borderRadius != null || radius != null
            ? RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(radius!))
            : null);

    final effectiveSplashFactory =
        splashFactory ?? ((noSplash ?? false) ? NoSplash.splashFactory : null);

    return MButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
      foregroundColor: foregroundColorProp,
      backgroundColor: backgroundColorProp,
      overlayColor: effectiveOverlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      iconColor: iconColorProp,
      iconSize: ButtonStyleButton.allOrNull<double>(iconSize),
      elevation: elevationValue,
      padding:
          ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(effectivePadding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(effectiveMinimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(effectiveSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(effectiveShape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: effectiveTapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: effectiveSplashFactory,
    );
  }

  static ButtonStyle defaultOf(
    BuildContext context, {
    bool? isSelected,
    MButtonIconAlignment? alignment,
    MButtonMode? mode,
  }) {
    final currentMode = mode ?? MButtonMode.text;
    final iconAlignment = alignment ?? MButtonIconAlignment.start;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final useMaterial3 = currentMode == MButtonMode.iconStandard ||
        currentMode == MButtonMode.iconFilled ||
        currentMode == MButtonMode.iconTonal ||
        currentMode == MButtonMode.iconOutlined ||
        currentMode == MButtonMode.filled ||
        currentMode == MButtonMode.tonal ||
        theme.useMaterial3;

    Color? foregroundColor = colorScheme.primary;
    Color? backgroundColor = Colors.transparent;
    final Color disabledForegroundColor =
        colorScheme.onSurface.withOpacity(0.38);
    Color? disabledBackgroundColor = Colors.transparent;
    Color? unselectedForegroundColor;
    Color? selectedForegroundColor;
    Color? unselectedBackgroundColor;
    Color? selectedBackgroundColor;
    Color? selectedDisabledBackgroundColor;
    Color? shadowColor = useMaterial3 ? Colors.transparent : theme.shadowColor;
    double? elevationValue = 0.0;
    MaterialStateProperty<double>? elevation;
    final textStyle = theme.textTheme.labelLarge;
    EdgeInsetsGeometry padding = _scaledPadding(context, mode: mode);
    Size minimumSize = Size(64.0, useMaterial3 ? 40.0 : 36.0);
    Color? iconColor;
    double? iconSize;
    BorderSide? sideValue;
    MaterialStateProperty<BorderSide?>? side;
    VisualDensity visualDensity = theme.visualDensity;
    Color? overlayColor = useMaterial3 ? colorScheme.primary : null;
    Color? overlayHighlightColor;
    Color? overlayUnselectedColor;
    Color? overlaySelectedColor;
    Color? surfaceTintColor = useMaterial3 ? Colors.transparent : null;

    switch (currentMode) {
      case MButtonMode.textIcon:
        final double defaultFontSize = textStyle?.fontSize ?? 14.0;
        final double effectiveTextScale =
            MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
        padding = ButtonStyleButton.scaledPadding(
          useMaterial3
              ? iconAlignment.isVertical
                  ? const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 16)
                  : const EdgeInsetsDirectional.fromSTEB(12, 8, 16, 8)
              : const EdgeInsets.all(8),
          iconAlignment.isVertical
              ? const EdgeInsets.symmetric(vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 4),
          iconAlignment.isVertical
              ? const EdgeInsets.symmetric(vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 4),
          effectiveTextScale,
        );
        break;
      case MButtonMode.elevated:
        foregroundColor =
            useMaterial3 ? colorScheme.primary : colorScheme.onPrimary;
        backgroundColor =
            useMaterial3 ? colorScheme.surface : colorScheme.primary;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        shadowColor = useMaterial3 ? colorScheme.shadow : theme.shadowColor;
        elevationValue = useMaterial3 ? null : 2.0;
        elevation = useMaterial3
            ? MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return 0.0;
                  }
                  if (states.contains(MaterialState.hovered)) {
                    return 3.0;
                  }
                  return 1.0;
                },
              )
            : null;
        surfaceTintColor = useMaterial3 ? colorScheme.surfaceTint : null;
        break;
      case MButtonMode.filled:
        foregroundColor = colorScheme.onPrimary;
        backgroundColor = colorScheme.primary;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        overlayColor = colorScheme.onPrimary;
        shadowColor = colorScheme.shadow;
        elevationValue = null;
        elevation = MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return 1.0;
            }
            return 0.0;
          },
        );
        break;
      case MButtonMode.tonal:
        foregroundColor = colorScheme.onSecondaryContainer;
        backgroundColor = colorScheme.secondaryContainer;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        overlayColor = colorScheme.onSecondaryContainer;
        shadowColor = colorScheme.shadow;
        elevationValue = null;
        elevation = MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return 1.0;
            }
            return 0.0;
          },
        );
        break;
      case MButtonMode.iconFilled:
        foregroundColor = colorScheme.onPrimary;
        backgroundColor = colorScheme.primary;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        unselectedForegroundColor = colorScheme.primary;
        unselectedBackgroundColor = colorScheme.surfaceVariant;
        selectedForegroundColor = colorScheme.onPrimary;
        selectedBackgroundColor = colorScheme.primary;
        overlayColor = colorScheme.onPrimary;
        overlayUnselectedColor = colorScheme.primary;
        padding = const EdgeInsets.all(8.0);
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        break;
      case MButtonMode.iconTonal:
        foregroundColor = colorScheme.onSecondaryContainer;
        backgroundColor = colorScheme.secondaryContainer;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        unselectedForegroundColor = colorScheme.onSurfaceVariant;
        unselectedBackgroundColor = colorScheme.surfaceVariant;
        selectedForegroundColor = colorScheme.onSecondaryContainer;
        selectedBackgroundColor = colorScheme.secondaryContainer;
        overlayColor = colorScheme.onSecondaryContainer;
        overlayUnselectedColor = colorScheme.onSurfaceVariant;
        padding = const EdgeInsets.all(8.0);
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        break;
      case MButtonMode.iconOutlined:
        foregroundColor = colorScheme.onSurfaceVariant;
        backgroundColor = Colors.transparent;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        unselectedForegroundColor = colorScheme.onInverseSurface;
        unselectedBackgroundColor = colorScheme.inverseSurface;
        selectedForegroundColor = null;
        selectedBackgroundColor = Colors.transparent;
        selectedDisabledBackgroundColor =
            colorScheme.onSurface.withOpacity(0.12);
        overlayColor = colorScheme.onSurfaceVariant;
        overlayHighlightColor = colorScheme.onSurface;
        overlaySelectedColor = colorScheme.onInverseSurface;
        padding = const EdgeInsets.all(8.0);
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        side = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return null;
          } else {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: colorScheme.onSurface.withOpacity(0.12));
            }
            return BorderSide(color: colorScheme.outline);
          }
        });
        break;
      case MButtonMode.iconStandard:
        foregroundColor = colorScheme.onSurfaceVariant;
        selectedForegroundColor = colorScheme.primary;
        overlayColor = colorScheme.onSurfaceVariant;
        overlaySelectedColor = colorScheme.primary;
        padding = const EdgeInsets.all(8.0);
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        break;
      case MButtonMode.outlined:
        sideValue = useMaterial3
            ? null
            : BorderSide(color: colorScheme.onSurface.withOpacity(0.12));
        side = useMaterial3
            ? MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return BorderSide(
                        color: colorScheme.onSurface.withOpacity(0.12));
                  }
                  if (states.contains(MaterialState.focused)) {
                    return BorderSide(color: colorScheme.primary);
                  }
                  return BorderSide(color: colorScheme.outline);
                },
              )
            : null;
      case MButtonMode.outlinedIcon:
        final double defaultFontSize = textStyle?.fontSize ?? 14.0;
        final double effectiveTextScale =
            MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
        padding = ButtonStyleButton.scaledPadding(
          const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
          const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
          const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
          effectiveTextScale,
        );
        sideValue = useMaterial3
            ? null
            : BorderSide(color: colorScheme.onSurface.withOpacity(0.12));
        side = useMaterial3
            ? MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return BorderSide(
                        color: colorScheme.onSurface.withOpacity(0.12));
                  }
                  if (states.contains(MaterialState.focused)) {
                    return BorderSide(color: colorScheme.primary);
                  }
                  return BorderSide(color: colorScheme.outline);
                },
              )
            : null;
        break;
      default:
        break;
    }

    return MButtonStyle.from(
      foregroundColor: foregroundColor,
      disabledForegroundColor: disabledForegroundColor,
      unselectedForegroundColor: unselectedForegroundColor,
      selectedForegroundColor: selectedForegroundColor,
      backgroundColor: backgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      unselectedBackgroundColor: unselectedBackgroundColor,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedDisabledBackgroundColor: selectedDisabledBackgroundColor,
      shadowColor: shadowColor,
      elevation: elevationValue,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      maximumSize: Size.infinite,
      iconColor: iconColor,
      iconSize: iconSize,
      side: sideValue,
      shape: useMaterial3
          ? const StadiumBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.basic,
      visualDensity: visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory:
          useMaterial3 ? theme.splashFactory : InkRipple.splashFactory,
      overlayColor: overlayColor,
      overlayHighlightColor: overlayHighlightColor,
      overlayUnselectedColor: overlayUnselectedColor,
      overlaySelectedColor: overlaySelectedColor,
      surfaceTintColor: surfaceTintColor,
      isSelected: isSelected,
      useMaterial3: useMaterial3,
    ).copyWith(
      elevation: elevation,
      side: side,
    );
  }
}

extension MButtonStyleExt on ButtonStyle {
  ButtonStyle copyFrom({
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? overlayColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    Color? iconColor,
    double? iconSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? mouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return copyWith(
      textStyle: ButtonStyleButton.allOrNull(textStyle) ?? this.textStyle,
      backgroundColor:
          ButtonStyleButton.allOrNull(backgroundColor) ?? this.backgroundColor,
      foregroundColor:
          ButtonStyleButton.allOrNull(foregroundColor) ?? this.foregroundColor,
      overlayColor:
          ButtonStyleButton.allOrNull(overlayColor) ?? this.overlayColor,
      shadowColor: ButtonStyleButton.allOrNull(shadowColor) ?? this.shadowColor,
      surfaceTintColor: ButtonStyleButton.allOrNull(surfaceTintColor) ??
          this.surfaceTintColor,
      elevation: ButtonStyleButton.allOrNull(elevation) ?? this.elevation,
      padding: ButtonStyleButton.allOrNull(padding) ?? this.padding,
      minimumSize: ButtonStyleButton.allOrNull(minimumSize) ?? this.minimumSize,
      fixedSize: ButtonStyleButton.allOrNull(fixedSize) ?? this.fixedSize,
      maximumSize: ButtonStyleButton.allOrNull(maximumSize) ?? this.maximumSize,
      iconColor: ButtonStyleButton.allOrNull(iconColor) ?? this.iconColor,
      iconSize: ButtonStyleButton.allOrNull(iconSize) ?? this.iconSize,
      side: ButtonStyleButton.allOrNull(side) ?? this.side,
      shape: ButtonStyleButton.allOrNull(shape) ?? this.shape,
      mouseCursor: ButtonStyleButton.allOrNull(mouseCursor) ?? this.mouseCursor,
      visualDensity: visualDensity ?? this.visualDensity,
      tapTargetSize: tapTargetSize ?? this.tapTargetSize,
      animationDuration: animationDuration ?? this.animationDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
      splashFactory: splashFactory ?? this.splashFactory,
    );
  }
}

EdgeInsetsGeometry _scaledPadding(
  BuildContext context, {
  MButtonMode? mode,
}) {
  final ThemeData theme = Theme.of(context);
  final useMaterial3 = theme.useMaterial3;
  final currentMode = mode ?? MButtonMode.text;
  final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale =
      MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;

  switch (currentMode) {
    case MButtonMode.elevated:
    case MButtonMode.filled:
    case MButtonMode.tonal:
    case MButtonMode.outlined:
      final double padding1x = useMaterial3 ? 24.0 : 16.0;
      return ButtonStyleButton.scaledPadding(
        EdgeInsets.symmetric(horizontal: padding1x),
        EdgeInsets.symmetric(horizontal: padding1x / 2),
        EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
        effectiveTextScale,
      );
    default:
      return ButtonStyleButton.scaledPadding(
        useMaterial3
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
            : const EdgeInsets.all(8),
        const EdgeInsets.symmetric(horizontal: 8),
        const EdgeInsets.symmetric(horizontal: 4),
        effectiveTextScale,
      );
  }
}

@immutable
class _MElevatedButtonDefaultElevation extends MaterialStateProperty<double>
    with Diagnosticable {
  _MElevatedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return 0;
    }
    if (states.contains(MaterialState.pressed)) {
      return elevation + 6;
    }
    if (states.contains(MaterialState.hovered)) {
      return elevation + 2;
    }
    if (states.contains(MaterialState.focused)) {
      return elevation + 2;
    }
    return elevation;
  }
}

enum MButtonIconAlignment {
  start,
  top,
  end,
  bottom,
}

extension MButtonIconAlignmentExt on MButtonIconAlignment {
  bool get isVertical {
    return this == MButtonIconAlignment.top ||
        this == MButtonIconAlignment.bottom;
  }

  bool get isTerminus {
    return this == MButtonIconAlignment.end ||
        this == MButtonIconAlignment.bottom;
  }
}
