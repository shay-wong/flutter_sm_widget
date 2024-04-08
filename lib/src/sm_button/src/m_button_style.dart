import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sm_logger/sm_logger.dart';

part '_m_button_default_style.dart';

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

///
/// [maximumSize] 最大尺寸
/// !: 注意 如果设置了 [maximumSize] 不设置 [minimumSize], 并且 [maximumSize] 小于 [minimumSize], 则会导致约束冲突.
/// !: BoxConstraints has both width and height constraints non-normalized.
///
class MButtonStyle extends ButtonStyle {
  const MButtonStyle({
    super.textStyle,
    super.backgroundColor,
    super.foregroundColor,
    MaterialStateProperty<Color?>? overlayColor,
    super.shadowColor,
    super.surfaceTintColor,
    super.elevation,
    MaterialStateProperty<EdgeInsetsGeometry?>? padding,
    MaterialStateProperty<Size?>? minimumSize,
    super.fixedSize,
    super.maximumSize,
    super.iconColor,
    super.iconSize,
    super.side,
    super.shape,
    super.mouseCursor,
    super.visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    super.animationDuration,
    super.enableFeedback,
    super.alignment,
    InteractiveInkFeatureFactory? splashFactory,
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
  }) : super(
          overlayColor: overlayColor ??
              (clearOverlay != null && clearOverlay
                  ? const MaterialStatePropertyAll(Colors.transparent)
                  : null),
          padding: padding ??
              (clearPadding != null && clearPadding
                  ? const MaterialStatePropertyAll(EdgeInsets.zero)
                  : null),
          minimumSize: minimumSize ??
              (clearPadding != null && clearPadding
                  ? const MaterialStatePropertyAll(Size.zero)
                  : null),
          tapTargetSize: tapTargetSize ??
              (clearPadding != null && clearPadding
                  ? MaterialTapTargetSize.shrinkWrap
                  : null),
          splashFactory: splashFactory ??
              (clearSplash != null && clearSplash
                  ? NoSplash.splashFactory
                  : null),
        );

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
    Color? overlayUnselectedColor,
    Color? overlayUnselectedFocusColor,
    Color? overlayUnselectedHighlightColor,
    Color? overlayUnselectedHoverColor,
    Color? overlaySelectedColor,
    Color? overlaySelectedFocusColor,
    Color? overlaySelectedHighlightColor,
    Color? overlaySelectedHoverColor,
    bool? clearOverlay,
    bool? clearSplash,
    double? width,
    double? height,
    double? size,
    bool? isSelected,
    bool? useMaterial3,
    MButtonMode? mode,
  }) {
    mode = mode ?? MButtonMode.text;
    final toggleable = isSelected != null;

    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foregroundColor == null &&
                disabledForegroundColor == null &&
                unselectedForegroundColor == null &&
                selectedForegroundColor == null &&
                selectedDisabledForegroundColor == null)
            ? null
            : _MButtonDefaultColor(
                foregroundColor,
                disabledForegroundColor,
                // [IconButton] 有默认值, 无需设置默认值为 foregroundColor
                unselectedForegroundColor ??
                    (mode.isIconButton ? null : foregroundColor),
                // [TextButton] 除了 disabledForegroundColor 其余默认值都为 foregroundColor
                selectedForegroundColor ??
                    (mode.isTextButton ? foregroundColor : null),
                selectedDisabledForegroundColor,
                toggleable,
              );

    final MaterialStateProperty<Color?>? backgroundColorProp =
        (backgroundColor == null &&
                disabledBackgroundColor == null &&
                unselectedBackgroundColor == null &&
                selectedBackgroundColor == null &&
                selectedDisabledBackgroundColor == null)
            ? null
            : _MButtonDefaultColor(
                backgroundColor,
                // [TextButton] 默认为透明, 需设置默认值为 backgroundColor
                disabledBackgroundColor ??
                    (mode.isTextButton ? backgroundColor : null),
                // [IconButton] 有默认值, 无需设置默认值为 backgroundColor
                unselectedBackgroundColor ??
                    (mode.isIconButton ? null : backgroundColor),
                selectedBackgroundColor,
                // [TextButton] 默认为透明, 需设置默认值为 backgroundColor
                selectedDisabledBackgroundColor ??
                    (mode.isTextButton ? selectedBackgroundColor : null),
                toggleable,
              );

    final overlaySetting = overlayColor == null &&
        overlayFocusColor == null &&
        overlayHighlightColor == null &&
        overlayHoverColor == null &&
        overlayUnselectedColor == null &&
        overlayUnselectedFocusColor == null &&
        overlayUnselectedHighlightColor == null &&
        overlayUnselectedHoverColor == null &&
        overlaySelectedColor == null &&
        overlaySelectedFocusColor == null &&
        overlaySelectedHighlightColor == null &&
        overlaySelectedHoverColor == null;

    final effectiveOverlayColor = overlaySetting && clearOverlay == null
        ? null
        : _MButtonDefaultOverlay(
            overlayColor ?? foregroundColor,
            overlayFocusColor,
            overlayHoverColor,
            overlayHighlightColor,
            overlayUnselectedColor,
            overlayUnselectedFocusColor,
            overlayUnselectedHoverColor,
            overlayUnselectedHighlightColor,
            overlaySelectedColor,
            overlaySelectedFocusColor,
            overlaySelectedHoverColor,
            overlaySelectedHighlightColor,
            clearOverlay != null && clearOverlay && overlaySetting,
            toggleable,
            useMaterial3 ?? true,
            mode,
          );
    if (clearOverlay != null && clearOverlay && !overlaySetting) {
      logger.w('overlayColors is not null, clearOverlay will be ignored');
    }

    final MaterialStateProperty<Color?>? iconColorProp =
        (iconColor == null && disabledIconColor == null)
            ? null
            : _MButtonDefaultIconColor(iconColor, disabledIconColor);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _MButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

    final MaterialStateProperty<double>? elevationValue = (elevation == null)
        ? null
        : mode == MButtonMode.elevated
            ? _MElevatedButtonDefaultElevation(elevation)
            : ButtonStyleButton.allOrNull<double>(elevation);

    final Size? effectiveSize = fixedSize ??
        ((width ?? size) != null || (height ?? size) != null
            ? Size(width ?? size ?? double.infinity,
                height ?? size ?? double.infinity)
            : null);
    final OutlinedBorder? effectiveShape = shape ??
        (borderRadius != null || radius != null
            ? RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(radius!))
            : null);

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
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(effectiveSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(effectiveShape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      clearPadding: clearPadding,
      clearOverlay: clearOverlay,
      clearSplash: clearSplash,
    );
  }

  /// 是否清除默认的 [_MButtonDefaultOverlay]
  final bool? clearOverlay;

  /// 是否清除默认 [_scaledPadding]
  final bool? clearPadding;

  /// 是否清除默认 [splashFactory]
  final bool? clearSplash;

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
    MaterialStateProperty<double>? elevation =
        _MButtonDefaultElevation(elevation: 0.0);
    final textStyle = theme.textTheme.labelLarge;
    final EdgeInsetsGeometry padding =
        _scaledPadding(context, iconAlignment: iconAlignment, mode: mode);
    Size minimumSize = Size(64.0, useMaterial3 ? 40.0 : 36.0);
    Color? iconColor;
    double? iconSize;
    MaterialStateProperty<BorderSide?>? side;
    VisualDensity visualDensity = theme.visualDensity;
    Color? overlayColor = useMaterial3 ? colorScheme.primary : null;
    Color? overlayHighlightColor;
    Color? overlayUnselectedColor;
    Color? overlaySelectedColor;
    Color? surfaceTintColor = useMaterial3 ? Colors.transparent : null;

    switch (currentMode) {
      case MButtonMode.elevated:
        foregroundColor =
            useMaterial3 ? colorScheme.primary : colorScheme.onPrimary;
        backgroundColor =
            useMaterial3 ? colorScheme.surface : colorScheme.primary;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        shadowColor = useMaterial3 ? colorScheme.shadow : theme.shadowColor;
        elevation = useMaterial3
            ? _MButtonDefaultElevation(elevation: 2.0)
            : _MButtonDefaultElevation(
                elevation: 1.0,
                pressed: 1.0,
                hovered: 3.0,
                focused: 1.0,
                disable: 0.0);
        surfaceTintColor = useMaterial3 ? colorScheme.surfaceTint : null;
        break;
      case MButtonMode.filled:
        foregroundColor = colorScheme.onPrimary;
        backgroundColor = colorScheme.primary;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        overlayColor = colorScheme.onPrimary;
        shadowColor = colorScheme.shadow;
        elevation = _MButtonDefaultElevation(
            elevation: 0.0,
            pressed: 0.0,
            hovered: 1.0,
            focused: 0.0,
            disable: 0.0);
        break;
      case MButtonMode.tonal:
        foregroundColor = colorScheme.onSecondaryContainer;
        backgroundColor = colorScheme.secondaryContainer;
        disabledBackgroundColor = colorScheme.onSurface.withOpacity(0.12);
        overlayColor = colorScheme.onSecondaryContainer;
        shadowColor = colorScheme.shadow;
        elevation = _MButtonDefaultElevation(
            elevation: 0.0,
            pressed: 0.0,
            hovered: 1.0,
            focused: 0.0,
            disable: 0.0);
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
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        side = _MButtonDefaultSide(
          colorScheme.outline,
          null,
          null,
          colorScheme.onSurface.withOpacity(0.12),
        );
        break;
      case MButtonMode.iconStandard:
        foregroundColor = colorScheme.onSurfaceVariant;
        selectedForegroundColor = colorScheme.primary;
        overlayColor = colorScheme.onSurfaceVariant;
        overlaySelectedColor = colorScheme.primary;
        minimumSize = const Size(40.0, 40.0);
        iconSize = 24.0;
        visualDensity = VisualDensity.standard;
        break;
      case MButtonMode.outlined:
      case MButtonMode.outlinedIcon:
        side = _MButtonDefaultSide(
          useMaterial3
              ? colorScheme.outline
              : colorScheme.onSurface.withOpacity(0.12),
          null,
          useMaterial3 ? colorScheme.primary : null,
          useMaterial3 ? colorScheme.onSurface.withOpacity(0.12) : null,
        );
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
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      maximumSize: Size.infinite,
      iconColor: iconColor,
      iconSize: iconSize,
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
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? unselectedForegroundColor,
    Color? unselectedBackgroundColor,
    Color? selectedForegroundColor,
    Color? selectedBackgroundColor,
    Color? selectedDisabledForegroundColor,
    Color? selectedDisabledBackgroundColor,
    Color? disabledIconColor,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    Color? overlayFocusColor,
    Color? overlayHighlightColor,
    Color? overlayHoverColor,
    Color? overlayUnselectedColor,
    Color? overlayUnselectedFocusColor,
    Color? overlayUnselectedHighlightColor,
    Color? overlayUnselectedHoverColor,
    Color? overlaySelectedColor,
    Color? overlaySelectedFocusColor,
    Color? overlaySelectedHighlightColor,
    Color? overlaySelectedHoverColor,
    bool? clearOverlay,
    bool? clearSplash,
    double? width,
    double? height,
    double? size,
    bool? isSelected,
    bool? useMaterial3,
    MButtonMode? mode,
  }) {
    mode = mode ?? MButtonMode.text;
    clearPadding = clearPadding ?? false;
    final toggleable = isSelected != null;

    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foregroundColor == null && disabledForegroundColor == null)
            ? null
            : _MButtonDefaultColor(
                foregroundColor,
                disabledForegroundColor,
                // [IconButton] 有默认值, 无需设置默认值为 foregroundColor
                unselectedForegroundColor ??
                    (mode.isIconButton ? null : foregroundColor),
                selectedForegroundColor,
                selectedDisabledForegroundColor,
                toggleable,
              );

    final MaterialStateProperty<Color?>? backgroundColorProp =
        (backgroundColor == null && disabledBackgroundColor == null)
            ? null
            : _MButtonDefaultColor(
                backgroundColor,
                // [TextButton] 默认为透明, 需设置默认值为 backgroundColor
                disabledBackgroundColor ??
                    (mode.isTextButton ? backgroundColor : null),
                // [IconButton] 有默认值, 无需设置默认值为 backgroundColor
                unselectedBackgroundColor ??
                    (mode.isIconButton ? null : backgroundColor),
                selectedBackgroundColor,
                // [TextButton] 默认为透明, 需设置默认值为 backgroundColor
                selectedDisabledBackgroundColor ??
                    (mode.isTextButton ? selectedBackgroundColor : null),
                toggleable,
              );

    final overlaySetting = overlayColor == null &&
        overlayFocusColor == null &&
        overlayHighlightColor == null &&
        overlayHoverColor == null &&
        overlayUnselectedColor == null &&
        overlayUnselectedFocusColor == null &&
        overlayUnselectedHighlightColor == null &&
        overlayUnselectedHoverColor == null &&
        overlaySelectedColor == null &&
        overlaySelectedFocusColor == null &&
        overlaySelectedHighlightColor == null &&
        overlaySelectedHoverColor == null;

    final effectiveOverlayColor = overlaySetting && clearOverlay == null
        ? null
        : _MButtonDefaultOverlay(
            overlayColor ?? foregroundColor,
            overlayFocusColor,
            overlayHoverColor,
            overlayHighlightColor,
            overlayUnselectedColor,
            overlayUnselectedFocusColor,
            overlayUnselectedHoverColor,
            overlayUnselectedHighlightColor,
            overlaySelectedColor,
            overlaySelectedFocusColor,
            overlaySelectedHoverColor,
            overlaySelectedHighlightColor,
            clearOverlay != null && clearOverlay && overlaySetting,
            toggleable,
            useMaterial3 ?? true,
            mode,
          );
    if (clearOverlay != null && clearOverlay && !overlaySetting) {
      logger.w('overlayColors is not null, clearOverlay will be ignored');
    }

    final MaterialStateProperty<Color?>? iconColorProp =
        (iconColor == null && disabledIconColor == null)
            ? null
            : _MButtonDefaultIconColor(iconColor, disabledIconColor);
    final MaterialStateProperty<MouseCursor?>? effectiveMouseCursor =
        enabledMouseCursor == null && disabledMouseCursor == null
            ? null
            : _MButtonDefaultMouseCursor(
                enabledMouseCursor, disabledMouseCursor);

    final MaterialStateProperty<double>? elevationValue = (elevation == null)
        ? null
        : mode == MButtonMode.elevated
            ? _MElevatedButtonDefaultElevation(elevation)
            : ButtonStyleButton.allOrNull<double>(elevation);

    final effectivePadding = padding ?? (clearPadding ? EdgeInsets.zero : null);
    final effectiveMinimumSize =
        minimumSize ?? (clearPadding ? Size.zero : null);
    final effectiveTapTargetSize = tapTargetSize ??
        (clearPadding ? MaterialTapTargetSize.shrinkWrap : null);

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

    final effectiveSplashFactory = splashFactory ??
        ((clearSplash ?? false) ? NoSplash.splashFactory : null);

    return copyWith(
      textStyle: ButtonStyleButton.allOrNull(textStyle) ?? this.textStyle,
      backgroundColor: backgroundColorProp ?? this.backgroundColor,
      foregroundColor: foregroundColorProp ?? this.foregroundColor,
      overlayColor: effectiveOverlayColor ?? this.overlayColor,
      shadowColor: ButtonStyleButton.allOrNull(shadowColor) ?? this.shadowColor,
      surfaceTintColor: ButtonStyleButton.allOrNull(surfaceTintColor) ??
          this.surfaceTintColor,
      elevation: elevationValue ?? this.elevation,
      padding: ButtonStyleButton.allOrNull(effectivePadding) ?? this.padding,
      minimumSize:
          ButtonStyleButton.allOrNull(effectiveMinimumSize) ?? this.minimumSize,
      fixedSize: ButtonStyleButton.allOrNull(effectiveSize) ?? this.fixedSize,
      maximumSize: ButtonStyleButton.allOrNull(maximumSize) ?? this.maximumSize,
      iconColor: iconColorProp ?? this.iconColor,
      iconSize: ButtonStyleButton.allOrNull(iconSize) ?? this.iconSize,
      side: ButtonStyleButton.allOrNull(side) ?? this.side,
      shape: ButtonStyleButton.allOrNull(effectiveShape) ?? this.shape,
      mouseCursor: ButtonStyleButton.allOrNull(mouseCursor) ??
          effectiveMouseCursor ??
          this.mouseCursor,
      visualDensity: visualDensity ?? this.visualDensity,
      tapTargetSize: effectiveTapTargetSize ?? this.tapTargetSize,
      animationDuration: animationDuration ?? this.animationDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
      splashFactory: effectiveSplashFactory ?? this.splashFactory,
    );
  }
}

/// Scaled padding for buttons
EdgeInsetsGeometry _scaledPadding(
  BuildContext context, {
  MButtonIconAlignment iconAlignment = MButtonIconAlignment.start,
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
    case MButtonMode.outlinedIcon:
      return ButtonStyleButton.scaledPadding(
        const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
        const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
        const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
        effectiveTextScale,
      );
    case MButtonMode.iconFilled:
    case MButtonMode.iconTonal:
    case MButtonMode.iconOutlined:
    case MButtonMode.iconStandard:
      return const EdgeInsets.all(8.0);
    case MButtonMode.textIcon:
      return ButtonStyleButton.scaledPadding(
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
