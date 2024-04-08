import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

part '_m_button.dart';

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
    this.clearPadding,
    this.clearOverlay,
    this.clearSplash,
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
    bool? isSelected,
    bool? clearOverlay,
    bool? clearPadding,
    bool? clearSplash,
    required Widget icon,
    Widget? label,
    MButtonIconAlignment? alignment,
    double? space,
  }) = _MButtonWithIcon;

  factory MButton.image({
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
    bool? isSelected,
    bool? clearOverlay,
    bool? clearPadding,
    bool? clearSplash,
    Widget? label,
    String? source,
    Widget? image,
    IconData? icon,
    MButtonIconAlignment? alignment,
    double? space,
  }) = _MButtonWithImage;

  factory MButton.text({
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
    bool? isSemanticButton,
    bool? isSelected,
    bool? clearOverlay,
    bool? clearPadding,
    bool? clearSplash,
    String? data,
    Widget? text,
  }) = _MButtonWithText;

  final bool? clearOverlay;
  final bool? clearPadding;
  final bool? clearSplash;

  /// 是否选中, 默认不选中, 设置 [statesController] 时无效
  final bool? isSelected;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return MButtonStyle.defaultOf(
      context,
      isSelected: isSelected,
      mode: MButtonMode.text,
    ).copyFrom(
      clearPadding: clearPadding,
      clearOverlay: clearOverlay,
      clearSplash: clearSplash,
    );
  }

  @override
  MaterialStatesController? get statesController =>
      super.statesController ??
      (isSelected != null && isSelected!
          ? MaterialStatesController(
              <MaterialState>{
                MaterialState.selected,
              },
            )
          : null);

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
      clearOverlay: clearOverlay,
      clearSplash: clearSplash,
      width: width,
      height: height,
      size: size,
      useMaterial3: useMaterial3,
      mode: mode ?? MButtonMode.text,
    );
  }
}
