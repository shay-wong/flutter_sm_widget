import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'm_button_style.dart';

const double _kMinButtonSize = kMinInteractiveDimension;

enum _MIconButtonVariant { standard, filled, filledTonal, outlined }

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
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
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
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
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
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
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
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
  })  : assert(splashRadius == null || splashRadius > 0),
        _variant = _MIconButtonVariant.outlined;

  final AlignmentGeometry? alignment;
  final bool autofocus;
  final BoxConstraints? constraints;
  final Color? disabledColor;
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
  final double? splashRadius;
  final String? tooltip;
  final VisualDensity? visualDensity;

  /// 是否清除默认的 [ButtonStyle.overlayColor]
  final bool? clearOverlay;

  /// 是否清除默认 [ButtonStyle.padding],
  /// 需要和 [padding] 保持在在同一层级, 要么都在 [style] 中设置.
  final bool? clearPadding;

  /// 是否清除默认 [ButtonStyle.splashFactory]
  final bool? clearSplash;

  /// 即 [ButtonStyle.foregroundColor]
  final Color? color;

  /// 即 [ButtonStyle.padding], 会合并到 [style] 中.
  /// 当 [style] 为 [ButtonStyle] 时，[ButtonStyle.padding] 为 null 时有效.
  /// 当 [style] 为 [MButtonStyle] 时，并且 [MButtonStyle.padding] 和 [MButtonStyle.clearPadding] 为 null 时有效.
  /// 需要和 [clearPadding] 保持在同一层级, 要么都在 [style] 中设置.
  final EdgeInsetsGeometry? padding;

  /// 按钮样式, 优先级最高, 当设置 [style] 中的样式后, 其他样式属性将失效
  final ButtonStyle? style;

  final _MIconButtonVariant _variant;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('icon', icon, showName: false));
    properties.add(
        StringProperty('tooltip', tooltip, defaultValue: null, quoted: false));
    properties.add(ObjectFlagProperty<VoidCallback>('onPressed', onPressed,
        ifNull: 'disabled'));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties
        .add(ColorProperty('disabledColor', disabledColor, defaultValue: null));
    properties.add(ColorProperty('focusColor', focusColor, defaultValue: null));
    properties.add(ColorProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(
        ColorProperty('highlightColor', highlightColor, defaultValue: null));
    properties
        .add(ColorProperty('splashColor', splashColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode,
        defaultValue: null));
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
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    bool? clearOverlay,
    bool? clearSplash,
    double? width,
    double? height,
    double? size,
    bool? useMaterial3,
    MButtonMode? mode,
  }) {
    return MButtonStyle.from(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      iconSize: iconSize,
      elevation: elevation,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      borderRadius: borderRadius,
      radius: radius,
      clearPadding: clearPadding,
      overlayColor: overlayColor,
      overlayFocusColor: focusColor,
      overlayHoverColor: hoverColor,
      overlayHighlightColor: highlightColor,
      clearOverlay: clearOverlay,
      clearSplash: clearSplash,
      width: width,
      height: height,
      size: size,
      useMaterial3: useMaterial3,
      mode: mode ?? MButtonMode.iconStandard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Material 3
    if (theme.useMaterial3) {
      final Size? minSize = constraints == null
          ? null
          : Size(constraints!.minWidth, constraints!.minHeight);
      final Size? maxSize = constraints == null
          ? null
          : Size(constraints!.maxWidth, constraints!.maxHeight);

      final mode = switch (_variant) {
        _MIconButtonVariant.filled => MButtonMode.iconFilled,
        _MIconButtonVariant.filledTonal => MButtonMode.iconTonal,
        _MIconButtonVariant.outlined => MButtonMode.iconOutlined,
        _MIconButtonVariant.standard => MButtonMode.iconStandard,
      };

      ButtonStyle adjustedStyle = styleFrom(
        visualDensity: visualDensity,
        foregroundColor: color,
        disabledForegroundColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        padding: padding,
        minimumSize: minSize,
        maximumSize: maxSize,
        iconSize: iconSize,
        alignment: alignment,
        enabledMouseCursor: mouseCursor,
        disabledMouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        clearPadding: clearPadding,
        clearOverlay: clearOverlay,
        clearSplash: clearSplash,
        mode: mode,
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

    // Material 2
    assert(debugCheckHasMaterial(context));

    Color? currentColor;
    if (onPressed != null) {
      currentColor = color;
    } else {
      currentColor = disabledColor ?? theme.disabledColor;
    }

    final VisualDensity effectiveVisualDensity =
        visualDensity ?? theme.visualDensity;

    final Size? minSize = style?.minimumSize?.resolve(const <MaterialState>{});
    final Size? maxSize = style?.maximumSize?.resolve(const <MaterialState>{});

    final BoxConstraints unadjustedConstraints = constraints ??
        BoxConstraints(
          minWidth: minSize?.width ?? _kMinButtonSize,
          minHeight: minSize?.height ?? _kMinButtonSize,
          maxWidth: maxSize?.width ?? double.infinity,
          maxHeight: maxSize?.height ?? double.infinity,
        );
    final BoxConstraints adjustedConstraints =
        effectiveVisualDensity.effectiveConstraints(unadjustedConstraints);
    final double effectiveIconSize = iconSize ??
        style?.iconSize?.resolve(const <MaterialState>{}) ??
        IconTheme.of(context).size ??
        24.0;
    final EdgeInsetsGeometry effectivePadding = padding ??
        style?.padding?.resolve(const <MaterialState>{}) ??
        const EdgeInsets.all(8.0);
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
        mouseCursor: mouseCursor ??
            (onPressed == null
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click),
        enableFeedback: effectiveEnableFeedback,
        focusColor: focusColor ?? theme.focusColor,
        hoverColor: hoverColor ?? theme.hoverColor,
        highlightColor: highlightColor ??
            style?.overlayColor?.resolve({
              MaterialState.pressed,
              MaterialState.focused,
              MaterialState.hovered,
              MaterialState.disabled,
            }) ??
            theme.highlightColor,
        splashColor: splashColor ??
            (style?.splashFactory == NoSplash.splashFactory
                ? null
                : theme.splashColor),
        splashFactory: style?.splashFactory,
        radius: splashRadius ??
            (style?.splashFactory == NoSplash.splashFactory &&
                    style?.overlayColor?.resolve({
                          MaterialState.pressed,
                          MaterialState.focused,
                          MaterialState.hovered,
                          MaterialState.disabled,
                        }) ==
                        null &&
                    highlightColor == null &&
                    splashColor == null &&
                    style?.splashFactory == null &&
                    focusColor == null &&
                    hoverColor == null
                ? 0.0
                : math.max(
                    Material.defaultSplashRadius,
                    (effectiveIconSize +
                            math.min(effectivePadding.horizontal,
                                effectivePadding.vertical)) *
                        0.7,
                    // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
                  )),
        child: result,
      ),
    );
  }
}

class _MIconButtonM3 extends ButtonStyleButton {
  const _MIconButtonM3({
    required super.onPressed,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.statesController,
    required this.variant,
    required this.isSelected,
    required Widget super.child,
  }) : super(
            onLongPress: null,
            onHover: null,
            onFocusChange: null,
            clipBehavior: Clip.none);

  final bool? isSelected;
  final _MIconButtonVariant variant;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    switch (variant) {
      case _MIconButtonVariant.filled:
        return MButtonStyle.defaultOf(context,
            isSelected: isSelected, mode: MButtonMode.iconFilled);
      case _MIconButtonVariant.filledTonal:
        return MButtonStyle.defaultOf(context,
            isSelected: isSelected, mode: MButtonMode.iconTonal);
      case _MIconButtonVariant.outlined:
        return MButtonStyle.defaultOf(context,
            isSelected: isSelected, mode: MButtonMode.iconOutlined);
      case _MIconButtonVariant.standard:
        return MButtonStyle.defaultOf(context,
            isSelected: isSelected, mode: MButtonMode.iconStandard);
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
    final bool isDefaultSize =
        iconTheme.size == const IconThemeData.fallback().size;

    final ButtonStyle iconThemeStyle = MIconButton.styleFrom(
      foregroundColor: isDefaultColor ? null : iconTheme.color,
      iconSize: isDefaultSize ? null : iconTheme.size,
    );

    return IconButtonTheme.of(context).style?.merge(iconThemeStyle) ??
        iconThemeStyle;
  }
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
      statesController = MaterialStatesController(
          <MaterialState>{if (widget.isSelected!) MaterialState.selected});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MIconButtonM3(
      statesController: statesController,
      style: widget.style,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onPressed: widget.onPressed,
      variant: widget.variant,
      isSelected: widget.isSelected,
      child: Semantics(
        selected: widget.isSelected,
        child: widget.child,
      ),
    );
  }
}
