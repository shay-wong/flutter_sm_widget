// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sm_widget/src/sm_button/src/m_button_style.dart';

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
    this.isSelected,
  });

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
    double? space,
    bool? isSelected,
  }) = _MButtonWithIcon;

  /// 是否选中
  final bool? isSelected;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return MButtonStyle.defaultOf(
      context,
      isSelected: isSelected,
      mode: MButtonMode.text,
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
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    Color? overlayColor,
    bool? noOverlay,
    bool? noSplash,
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
      iconColor: iconColor,
      disabledIconColor: disabledIconColor,
      elevation: elevation,
      textStyle: textStyle,
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
      noOverlay: noOverlay,
      noSplash: noSplash,
      width: width,
      height: height,
      size: size,
      useMaterial3: useMaterial3,
      mode: mode ?? MButtonMode.text,
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
    double? space,
    super.isSelected,
  })  : alignment = alignment ?? MButtonIconAlignment.start,
        super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _MButtonWithIconChild(
            icon: icon,
            label: label,
            space: space,
            alignment: alignment ?? MButtonIconAlignment.start,
          ),
        );

  final MButtonIconAlignment alignment;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return MButtonStyle.defaultOf(
      context,
      isSelected: isSelected,
      alignment: alignment,
      mode: MButtonMode.textIcon,
    );
  }
}

class _MButtonWithIconChild extends StatelessWidget {
  const _MButtonWithIconChild({
    this.label,
    required this.icon,
    this.space,
    this.alignment = MButtonIconAlignment.start,
  });

  final MButtonIconAlignment alignment;
  final Widget icon;
  final Widget? label;
  final double? space;

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return icon;
    }
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    // [icon] 和 [label] 的默认间距
    final gap = alignment.isVertical ? 6.0 : 8.0;
    final double effectiveGap = space ?? (scale <= 1 ? gap : lerpDouble(gap, gap / 2, math.min(scale - 1, 1))!);
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
