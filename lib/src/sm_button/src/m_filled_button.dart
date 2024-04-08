// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'm_button_style.dart';

enum _MFilledButtonVariant { filled, tonal }

class MFilledButton extends ButtonStyleButton {
  const MFilledButton({
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
  }) : _variant = _MFilledButtonVariant.filled;

  factory MFilledButton.icon({
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
    required Widget label,
  }) = _MFilledButtonWithIcon;

  const MFilledButton.tonal({
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
  }) : _variant = _MFilledButtonVariant.tonal;

  factory MFilledButton.tonalIcon({
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
    required Widget label,
  }) {
    return _MFilledButtonWithIcon.tonal(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      icon: icon,
      label: label,
    );
  }

  final _MFilledButtonVariant _variant;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return MButtonStyle.defaultOf(
      context,
      mode: _variant == _MFilledButtonVariant.filled ? MButtonMode.filled : MButtonMode.tonal,
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return FilledButtonTheme.of(context).style;
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
    BorderRadius? borderRadius,
    double? radius,
    bool? clearPadding,
    Color? overlayColor,
    bool? noOverlay,
    bool? noSplash,
    double? width,
    double? height,
    double? size,
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
      noOverlay: noOverlay,
      noSplash: noSplash,
      width: width,
      height: height,
      size: size,
      useMaterial3: true,
      mode: MButtonMode.filled,
    );
  }
}

class _MFilledButtonWithIcon extends MFilledButton {
  _MFilledButtonWithIcon({
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
    required Widget label,
  }) : super(
            autofocus: autofocus ?? false,
            clipBehavior: clipBehavior ?? Clip.none,
            child: _MFilledButtonWithIconChild(icon: icon, label: label));

  _MFilledButtonWithIcon.tonal({
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
    required Widget label,
  }) : super.tonal(
            autofocus: autofocus ?? false,
            clipBehavior: clipBehavior ?? Clip.none,
            child: _MFilledButtonWithIconChild(icon: icon, label: label));

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    final ButtonStyle buttonStyle = super.defaultStyleOf(context);
    final double defaultFontSize = buttonStyle.textStyle?.resolve(const <MaterialState>{})?.fontSize ?? 14.0;
    final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;

    final EdgeInsetsGeometry scaledPadding = useMaterial3
        ? ButtonStyleButton.scaledPadding(
            const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
            const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
            const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
            effectiveTextScale,
          )
        : ButtonStyleButton.scaledPadding(
            const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
            const EdgeInsets.symmetric(horizontal: 8),
            const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
            effectiveTextScale,
          );
    return buttonStyle.copyWith(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

class _MFilledButtonWithIconChild extends StatelessWidget {
  const _MFilledButtonWithIconChild({required this.label, required this.icon});

  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    // Adjust the gap based on the text scale factor. Start at 8, and lerp
    // to 4 based on how large the text is.
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}
