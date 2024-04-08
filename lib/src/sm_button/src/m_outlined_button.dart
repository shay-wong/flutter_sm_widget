// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'm_button_style.dart';

class MOutlinedButton extends ButtonStyleButton {
  const MOutlinedButton({
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
    required super.child,
    this.isSelected,
  });

  factory MOutlinedButton.icon({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
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
  }) = _MOutlinedButtonWithIcon;

  /// 是否选中
  final bool? isSelected;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return MButtonStyle.defaultOf(
      context,
      isSelected: isSelected,
      mode: MButtonMode.outlined,
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return OutlinedButtonTheme.of(context).style;
  }

  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
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
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    bool? clearOverlay,
    bool? clearSplash,
    double? width,
    double? height,
    double? size,
    bool? useMaterial3,
  }) {
    return MButtonStyle.from(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
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
      clearOverlay: clearOverlay,
      clearSplash: clearSplash,
      width: width,
      height: height,
      size: size,
      useMaterial3: useMaterial3,
      mode: MButtonMode.outlined,
    );
  }
}

class _MOutlinedButtonWithIcon extends MOutlinedButton {
  _MOutlinedButtonWithIcon({
    super.key,
    super.onPressed,
    super.onLongPress,
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
          child: _MOutlinedButtonWithIconChild(
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
      mode: MButtonMode.outlinedIcon,
    );
  }
}

class _MOutlinedButtonWithIconChild extends StatelessWidget {
  const _MOutlinedButtonWithIconChild({
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
    final double effectiveGap = space ??
        (scale <= 1 ? gap : lerpDouble(gap, gap / 2, math.min(scale - 1, 1))!);
    final effectiveIcon = Flexible(child: icon);
    final effectiveSpace = alignment.isVertical
        ? SizedBox(height: effectiveGap)
        : SizedBox(width: effectiveGap);
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
