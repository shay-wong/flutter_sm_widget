import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kMinButtonSize = kMinInteractiveDimension;

enum _MIconButtonVariant { standard, filled, filledTonal, outlined }

class _FilledMIconButtonDefaultsM3 extends ButtonStyle {
  _FilledMIconButtonDefaultsM3(this.context, this.toggleable)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  final bool toggleable;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  // No default text style

  @override
  MaterialStateProperty<Color?>? get backgroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.primary;
        }
        if (toggleable) {
          // toggleable but unselected case
          return _colors.surfaceVariant;
        }
        return _colors.primary;
      });

  @override
  MaterialStateProperty<double>? get elevation => const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.onPrimary;
        }
        if (toggleable) {
          // toggleable but unselected case
          return _colors.primary;
        }
        return _colors.onPrimary;
      });

  @override
  MaterialStateProperty<double>? get iconSize => const MaterialStatePropertyAll<double>(24.0);

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize => const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize => const MaterialStatePropertyAll<Size>(Size(40.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          if (states.contains(MaterialState.pressed)) {
            return _colors.onPrimary.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.onPrimary.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.onPrimary.withOpacity(0.12);
          }
        }
        if (toggleable) {
          // toggleable but unselected case
          if (states.contains(MaterialState.pressed)) {
            return _colors.primary.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.primary.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.primary.withOpacity(0.12);
          }
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onPrimary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        return Colors.transparent;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8.0));

  @override
  MaterialStateProperty<Color>? get shadowColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<OutlinedBorder>? get shape => const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<BorderSide?>? get side => null;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  VisualDensity? get visualDensity => VisualDensity.standard;
}

class _FilledTonalMIconButtonDefaultsM3 extends ButtonStyle {
  _FilledTonalMIconButtonDefaultsM3(this.context, this.toggleable)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  final bool toggleable;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  // No default text style

  @override
  MaterialStateProperty<Color?>? get backgroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.secondaryContainer;
        }
        if (toggleable) {
          // toggleable but unselected case
          return _colors.surfaceVariant;
        }
        return _colors.secondaryContainer;
      });

  @override
  MaterialStateProperty<double>? get elevation => const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.onSecondaryContainer;
        }
        if (toggleable) {
          // toggleable but unselected case
          return _colors.onSurfaceVariant;
        }
        return _colors.onSecondaryContainer;
      });

  @override
  MaterialStateProperty<double>? get iconSize => const MaterialStatePropertyAll<double>(24.0);

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize => const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize => const MaterialStatePropertyAll<Size>(Size(40.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          if (states.contains(MaterialState.pressed)) {
            return _colors.onSecondaryContainer.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.onSecondaryContainer.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.onSecondaryContainer.withOpacity(0.12);
          }
        }
        if (toggleable) {
          // toggleable but unselected case
          if (states.contains(MaterialState.pressed)) {
            return _colors.onSurfaceVariant.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.onSurfaceVariant.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.onSurfaceVariant.withOpacity(0.12);
          }
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSecondaryContainer.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSecondaryContainer.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSecondaryContainer.withOpacity(0.12);
        }
        return Colors.transparent;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8.0));

  @override
  MaterialStateProperty<Color>? get shadowColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<OutlinedBorder>? get shape => const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<BorderSide?>? get side => null;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  VisualDensity? get visualDensity => VisualDensity.standard;
}

class MIconButton extends StatelessWidget {
  const MIconButton({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
    this.backgroundColor,
    this.clearPadding = false,
    this.elevation,
    this.size,
    this.maximumSize,
    this.minimumSize,
    this.noHighlight = false,
    this.noSplash = false,
    this.overlayColor,
    this.shadowColor,
    this.shape,
    this.side,
    this.splashFactory,
    this.tapTargetSize,
  })  : assert(splashRadius == null || splashRadius > 0),
        _variant = _MIconButtonVariant.standard;

  const MIconButton.filled({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
    this.backgroundColor,
    this.clearPadding = false,
    this.elevation,
    this.size,
    this.maximumSize,
    this.minimumSize,
    this.noHighlight = false,
    this.noSplash = false,
    this.overlayColor,
    this.shadowColor,
    this.shape,
    this.side,
    this.splashFactory,
    this.tapTargetSize,
  })  : assert(splashRadius == null || splashRadius > 0),
        _variant = _MIconButtonVariant.filled;

  const MIconButton.filledTonal({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
    this.backgroundColor,
    this.clearPadding = false,
    this.elevation,
    this.size,
    this.maximumSize,
    this.minimumSize,
    this.noHighlight = false,
    this.noSplash = false,
    this.overlayColor,
    this.shadowColor,
    this.shape,
    this.side,
    this.splashFactory,
    this.tapTargetSize,
  })  : assert(splashRadius == null || splashRadius > 0),
        _variant = _MIconButtonVariant.filledTonal;

  const MIconButton.outlined({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    required this.icon,
    this.backgroundColor,
    this.clearPadding = false,
    this.elevation,
    this.size,
    this.maximumSize,
    this.minimumSize,
    this.noHighlight = false,
    this.noSplash = false,
    this.overlayColor,
    this.shadowColor,
    this.shape,
    this.side,
    this.splashFactory,
    this.tapTargetSize,
  })  : assert(splashRadius == null || splashRadius > 0),
        _variant = _MIconButtonVariant.outlined;

  final AlignmentGeometry? alignment;
  final bool autofocus;
  final BoxConstraints? constraints;
  final Color? disabledColor;
  final double? elevation;
  final bool? enableFeedback;
  final Color? focusColor;
  final FocusNode? focusNode;
  final Color? highlightColor;
  final Color? hoverColor;
  final Widget icon;
  final double? iconSize;
  final bool? isSelected;
  final MouseCursor? mouseCursor;
  final VoidCallback? onPressed;
  final Widget? selectedIcon;
  final Color? splashColor;
  final ButtonStyle? style;
  final String? tooltip;
  final VisualDensity? visualDensity;

  /// 背景颜色, 只在 Material 3 生效
  final Color? backgroundColor;

  /// 是否去除边距
  final bool clearPadding;

  /// 即 foregroundColor
  final Color? color;

  /// 限制大小
  final double? size;

  /// 最大尺寸
  /// !!!: 注意 [Material 3] 下 [minimumSize] 默认为 40x40.
  /// !!!: 如果设置了 [maximumSize] 不设置 [minimumSize], 并且 [maximumSize] 小于 [minimumSize], 则会导致约束冲突.
  /// BoxConstraints has both width and height constraints non-normalized.
  final Size? maximumSize;

  /// 最小尺寸
  final Size? minimumSize;

  /// 只去除默认的高亮颜色, 如果设置了 [highlightColor] 或 [overlayColor] 则 [noHighlight] 无效
  final bool noHighlight;

  /// 只去除默认的飞溅效果, 如果设置了 [splashColor] 或 [splashFactory] 则 [noSplash] 无效
  final bool noSplash;

  /// 如果设置了 [overlayColor] 则 [noHighlight] 无效
  final Color? overlayColor;

  /// 如果设置了 [padding] 则 [clearPadding] 无效
  final EdgeInsetsGeometry? padding;

  /// 只在 Material 3 生效
  final Color? shadowColor;

  /// 只在 Material 3 生效
  final OutlinedBorder? shape;

  /// 只在 Material 3 生效
  final BorderSide? side;

  /// 如果设置了 [splashFactory] 则 [noSplash] 无效
  final InteractiveInkFeatureFactory? splashFactory;

  /// 只在 Material 2 生效
  final double? splashRadius;

  /// 只在 Material 3 生效
  final MaterialTapTargetSize? tapTargetSize;

  final _MIconButtonVariant _variant;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('icon', icon, showName: false));
    properties.add(StringProperty('tooltip', tooltip, defaultValue: null, quoted: false));
    properties.add(ObjectFlagProperty<VoidCallback>('onPressed', onPressed, ifNull: 'disabled'));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('disabledColor', disabledColor, defaultValue: null));
    properties.add(ColorProperty('focusColor', focusColor, defaultValue: null));
    properties.add(ColorProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(ColorProperty('highlightColor', highlightColor, defaultValue: null));
    properties.add(ColorProperty('splashColor', splashColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    // TODO: add custom properties
  }

  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    double? iconSize,
    BorderSide? side,
    OutlinedBorder? shape,
    EdgeInsetsGeometry? padding,
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
    final MaterialStateProperty<Color?>? buttonBackgroundColor =
        (backgroundColor == null && disabledBackgroundColor == null)
            ? null
            : _MIconButtonDefaultBackground(backgroundColor, disabledBackgroundColor);
    final MaterialStateProperty<Color?>? buttonForegroundColor =
        (foregroundColor == null && disabledForegroundColor == null)
            ? null
            : _MIconButtonDefaultForeground(foregroundColor, disabledForegroundColor);
    final MaterialStateProperty<Color?>? effectiveOverlayColor = (overlayColor == null &&
            foregroundColor == null &&
            hoverColor == null &&
            focusColor == null &&
            highlightColor == null)
        ? null
        : _MIconButtonDefaultOverlay(foregroundColor, focusColor, hoverColor, highlightColor, overlayColor);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _MIconButtonDefaultMouseCursor(enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      backgroundColor: buttonBackgroundColor,
      foregroundColor: buttonForegroundColor,
      overlayColor: effectiveOverlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: ButtonStyleButton.allOrNull<double>(elevation),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      iconSize: ButtonStyleButton.allOrNull<double>(iconSize),
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (theme.useMaterial3) {
      final Size? minSize = constraints == null ? minimumSize : Size(constraints!.minWidth, constraints!.minHeight);
      final Size? maxSize = constraints == null ? maximumSize : Size(constraints!.maxWidth, constraints!.maxHeight);

      ButtonStyle adjustedStyle = styleFrom(
        visualDensity: visualDensity,
        foregroundColor: color,
        disabledForegroundColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        padding: padding ?? (clearPadding ? EdgeInsets.zero : null),
        minimumSize: minSize ?? (clearPadding ? Size.zero : null),
        maximumSize: maxSize,
        iconSize: iconSize,
        alignment: alignment,
        enabledMouseCursor: mouseCursor,
        disabledMouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        backgroundColor: backgroundColor,
        elevation: elevation,
        fixedSize: size == null ? null : Size(size!, size!),
        shape: shape,
        shadowColor: shadowColor,
        side: side,
        splashFactory: splashFactory ?? (noSplash ? NoSplash.splashFactory : null),
        tapTargetSize: tapTargetSize ?? (clearPadding ? MaterialTapTargetSize.shrinkWrap : null),
        overlayColor: overlayColor ?? (noHighlight ? Colors.transparent : null), // TODO: 没有高亮暂时用透明色
      );
      if (style != null) {
        adjustedStyle = style!.merge(adjustedStyle);
      }

      Widget effectiveIcon = icon;
      if ((isSelected ?? false) && selectedIcon != null) {
        effectiveIcon = selectedIcon!;
      }

      Widget iconButton = effectiveIcon;
      if (tooltip != null) {
        iconButton = Tooltip(
          message: tooltip,
          child: effectiveIcon,
        );
      }

      return _SelectableMIconButton(
        style: adjustedStyle,
        onPressed: onPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        isSelected: isSelected,
        variant: _variant,
        child: iconButton,
      );
    }
    assert(debugCheckHasMaterial(context));

    Color? currentColor;
    if (onPressed != null) {
      currentColor = color;
    } else {
      currentColor = disabledColor ?? theme.disabledColor;
    }

    final VisualDensity effectiveVisualDensity = visualDensity ?? theme.visualDensity;

    final BoxConstraints unadjustedConstraints = constraints ??
        BoxConstraints(
          minWidth: minimumSize?.width ?? _kMinButtonSize,
          minHeight: minimumSize?.height ?? _kMinButtonSize,
          maxWidth: maximumSize?.width ?? double.infinity,
          maxHeight: maximumSize?.height ?? double.infinity,
        );
    final BoxConstraints adjustedConstraints = effectiveVisualDensity.effectiveConstraints(unadjustedConstraints);
    final double effectiveIconSize = iconSize ?? size ?? IconTheme.of(context).size ?? 24.0;
    final EdgeInsetsGeometry effectivePadding = padding ?? (clearPadding ? EdgeInsets.zero : const EdgeInsets.all(8.0));
    final AlignmentGeometry effectiveAlignment = alignment ?? Alignment.center;
    final bool effectiveEnableFeedback = enableFeedback ?? true;

    Widget result = ConstrainedBox(
      constraints: adjustedConstraints,
      child: Padding(
        padding: effectivePadding,
        child: SizedBox(
          height: effectiveIconSize,
          width: effectiveIconSize,
          child: Align(
            alignment: effectiveAlignment,
            child: IconTheme.merge(
              data: IconThemeData(
                size: effectiveIconSize,
                color: currentColor,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip,
        child: result,
      );
    }

    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: InkResponse(
        focusNode: focusNode,
        autofocus: autofocus,
        canRequestFocus: onPressed != null,
        onTap: onPressed,
        mouseCursor: mouseCursor ?? (onPressed == null ? SystemMouseCursors.basic : SystemMouseCursors.click),
        enableFeedback: effectiveEnableFeedback,
        focusColor: focusColor ?? theme.focusColor,
        hoverColor: hoverColor ?? theme.hoverColor,
        highlightColor: highlightColor ?? (noHighlight ? null : theme.highlightColor),
        splashColor: splashColor ?? (noSplash ? null : theme.splashColor),
        splashFactory: splashFactory ?? (noSplash ? NoSplash.splashFactory : null),
        radius: splashRadius ??
            (noSplash &&
                    noHighlight &&
                    highlightColor == null &&
                    splashColor == null &&
                    splashFactory == null &&
                    focusColor == null &&
                    hoverColor == null
                ? 0.0
                : math.max(
                    Material.defaultSplashRadius,
                    (effectiveIconSize + math.min(effectivePadding.horizontal, effectivePadding.vertical)) * 0.7,
                    // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
                  )),
        child: result,
      ),
    );
  }
}

@immutable
class _MIconButtonDefaultBackground extends MaterialStateProperty<Color?> {
  _MIconButtonDefaultBackground(this.background, this.disabledBackground);

  final Color? background;
  final Color? disabledBackground;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledBackground;
    }
    return background;
  }

  @override
  String toString() {
    return '{disabled: $disabledBackground, otherwise: $background}';
  }
}

@immutable
class _MIconButtonDefaultForeground extends MaterialStateProperty<Color?> {
  _MIconButtonDefaultForeground(this.foregroundColor, this.disabledForegroundColor);

  final Color? disabledForegroundColor;
  final Color? foregroundColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledForegroundColor;
    }
    return foregroundColor;
  }

  @override
  String toString() {
    return '{disabled: $disabledForegroundColor, otherwise: $foregroundColor}';
  }
}

@immutable
class _MIconButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _MIconButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

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
class _MIconButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _MIconButtonDefaultOverlay(
    this.foregroundColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
  );

  final Color? focusColor;
  final Color? foregroundColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? overlayColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      if (states.contains(MaterialState.pressed)) {
        return highlightColor ?? overlayColor ?? foregroundColor?.withOpacity(0.12);
      }
      if (states.contains(MaterialState.hovered)) {
        return hoverColor ?? overlayColor ?? foregroundColor?.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return focusColor ?? overlayColor ?? foregroundColor?.withOpacity(0.12);
      }
    }
    if (states.contains(MaterialState.pressed)) {
      return highlightColor ?? overlayColor ?? foregroundColor?.withOpacity(0.12);
    }
    if (states.contains(MaterialState.hovered)) {
      return hoverColor ?? overlayColor ?? foregroundColor?.withOpacity(0.08);
    }
    if (states.contains(MaterialState.focused)) {
      return focusColor ?? overlayColor ?? foregroundColor?.withOpacity(0.08);
    }
    return null;
  }

  @override
  String toString() {
    return '{hovered: $hoverColor, focused: $focusColor, pressed: $highlightColor, otherwise: null}';
  }
}

class _MIconButtonDefaultsM3 extends ButtonStyle {
  _MIconButtonDefaultsM3(this.context, this.toggleable)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  final bool toggleable;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  // No default text style

  @override
  MaterialStateProperty<Color?>? get backgroundColor => const MaterialStatePropertyAll<Color?>(Colors.transparent);

  @override
  MaterialStateProperty<double>? get elevation => const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.primary;
        }
        return _colors.onSurfaceVariant;
      });

  @override
  MaterialStateProperty<double>? get iconSize => const MaterialStatePropertyAll<double>(24.0);

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize => const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize => const MaterialStatePropertyAll<Size>(Size(40.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          if (states.contains(MaterialState.pressed)) {
            return _colors.primary.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.primary.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.primary.withOpacity(0.12);
          }
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSurfaceVariant.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSurfaceVariant.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSurfaceVariant.withOpacity(0.12);
        }
        return Colors.transparent;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8.0));

  @override
  MaterialStateProperty<Color>? get shadowColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<OutlinedBorder>? get shape => const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<BorderSide?>? get side => null;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  VisualDensity? get visualDensity => VisualDensity.standard;
}

class _MIconButtonM3 extends ButtonStyleButton {
  const _MIconButtonM3({
    required super.onPressed,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.statesController,
    required this.variant,
    required this.toggleable,
    required Widget super.child,
  }) : super(onLongPress: null, onHover: null, onFocusChange: null, clipBehavior: Clip.none);

  final bool toggleable;
  final _MIconButtonVariant variant;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    switch (variant) {
      case _MIconButtonVariant.filled:
        return _FilledMIconButtonDefaultsM3(context, toggleable);
      case _MIconButtonVariant.filledTonal:
        return _FilledTonalMIconButtonDefaultsM3(context, toggleable);
      case _MIconButtonVariant.outlined:
        return _OutlinedMIconButtonDefaultsM3(context, toggleable);
      case _MIconButtonVariant.standard:
        return _MIconButtonDefaultsM3(context, toggleable);
    }
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    bool isIconThemeDefault(Color? color) {
      if (isDark) {
        return identical(color, kDefaultIconLightColor);
      }
      return identical(color, kDefaultIconDarkColor);
    }

    final bool isDefaultColor = isIconThemeDefault(iconTheme.color);
    final bool isDefaultSize = iconTheme.size == const IconThemeData.fallback().size;

    final ButtonStyle iconThemeStyle = MIconButton.styleFrom(
      foregroundColor: isDefaultColor ? null : iconTheme.color,
      iconSize: isDefaultSize ? null : iconTheme.size,
    );

    return IconButtonTheme.of(context).style?.merge(iconThemeStyle) ?? iconThemeStyle;
  }
}

class _OutlinedMIconButtonDefaultsM3 extends ButtonStyle {
  _OutlinedMIconButtonDefaultsM3(this.context, this.toggleable)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  final bool toggleable;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  // No default text style

  @override
  MaterialStateProperty<Color?>? get backgroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          if (states.contains(MaterialState.selected)) {
            return _colors.onSurface.withOpacity(0.12);
          }
          return Colors.transparent;
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.inverseSurface;
        }
        return Colors.transparent;
      });

  @override
  MaterialStateProperty<double>? get elevation => const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.onInverseSurface;
        }
        return _colors.onSurfaceVariant;
      });

  @override
  MaterialStateProperty<double>? get iconSize => const MaterialStatePropertyAll<double>(24.0);

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize => const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize => const MaterialStatePropertyAll<Size>(Size(40.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          if (states.contains(MaterialState.pressed)) {
            return _colors.onInverseSurface.withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return _colors.onInverseSurface.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.onInverseSurface.withOpacity(0.08);
          }
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSurfaceVariant.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSurfaceVariant.withOpacity(0.08);
        }
        return Colors.transparent;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8.0));

  @override
  MaterialStateProperty<Color>? get shadowColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<OutlinedBorder>? get shape => const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<BorderSide?>? get side => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        } else {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(color: _colors.onSurface.withOpacity(0.12));
          }
          return BorderSide(color: _colors.outline);
        }
      });

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor => const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  VisualDensity? get visualDensity => VisualDensity.standard;
}

class _SelectableMIconButton extends StatefulWidget {
  const _SelectableMIconButton({
    this.isSelected,
    this.style,
    this.focusNode,
    required this.variant,
    required this.autofocus,
    required this.onPressed,
    required this.child,
  });

  final bool autofocus;
  final Widget child;
  final FocusNode? focusNode;
  final bool? isSelected;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final _MIconButtonVariant variant;

  @override
  State<_SelectableMIconButton> createState() => _SelectableMIconButtonState();
}

class _SelectableMIconButtonState extends State<_SelectableMIconButton> {
  late final MaterialStatesController statesController;

  @override
  void didUpdateWidget(_SelectableMIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected == null) {
      if (statesController.value.contains(MaterialState.selected)) {
        statesController.update(MaterialState.selected, false);
      }
      return;
    }
    if (widget.isSelected != oldWidget.isSelected) {
      statesController.update(MaterialState.selected, widget.isSelected!);
    }
  }

  @override
  void dispose() {
    statesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isSelected == null) {
      statesController = MaterialStatesController();
    } else {
      statesController = MaterialStatesController(<MaterialState>{if (widget.isSelected!) MaterialState.selected});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool toggleable = widget.isSelected != null;

    return _MIconButtonM3(
      statesController: statesController,
      style: widget.style,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onPressed: widget.onPressed,
      variant: widget.variant,
      toggleable: toggleable,
      child: Semantics(
        selected: widget.isSelected,
        child: widget.child,
      ),
    );
  }
}
