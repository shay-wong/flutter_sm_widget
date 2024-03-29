import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    switch (_variant) {
      case _MFilledButtonVariant.filled:
        return _MFilledButtonDefaultsM3(context);
      case _MFilledButtonVariant.tonal:
        return _FilledTonalButtonDefaultsM3(context);
    }
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
  }) {
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (backgroundColor == null && disabledBackgroundColor == null)
            ? null
            : _MFilledButtonDefaultColor(
                backgroundColor, disabledBackgroundColor);
    final Color? foreground = foregroundColor;
    final Color? disabledForeground = disabledForegroundColor;
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _MFilledButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor =
        (foreground == null) ? null : _MFilledButtonDefaultOverlay(foreground);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _MFilledButtonDefaultMouseCursor(
            enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: ButtonStyleButton.allOrNull(elevation),
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

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale =
      MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
  final double padding1x = theme.useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    effectiveTextScale,
  );
}

@immutable
class _MFilledButtonDefaultColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _MFilledButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _MFilledButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _MFilledButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

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
class _MFilledButtonDefaultOverlay extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _MFilledButtonDefaultOverlay(this.overlay);

  final Color overlay;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return overlay.withOpacity(0.12);
    }
    if (states.contains(MaterialState.hovered)) {
      return overlay.withOpacity(0.08);
    }
    if (states.contains(MaterialState.focused)) {
      return overlay.withOpacity(0.12);
    }
    return null;
  }
}

class _MFilledButtonDefaultsM3 extends ButtonStyle {
  _MFilledButtonDefaultsM3(this.context)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.primary;
      });

  @override
  MaterialStateProperty<double>? get elevation =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return 0.0;
        }
        if (states.contains(MaterialState.pressed)) {
          return 0.0;
        }
        if (states.contains(MaterialState.hovered)) {
          return 1.0;
        }
        if (states.contains(MaterialState.focused)) {
          return 0.0;
        }
        return 0.0;
      });

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.onPrimary;
      });

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
      const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onPrimary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      MaterialStatePropertyAll<Color>(_colors.shadow);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
      const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      Theme.of(context).materialTapTargetSize;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
      MaterialStatePropertyAll<TextStyle?>(
          Theme.of(context).textTheme.labelLarge);

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;
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
    final double defaultFontSize =
        buttonStyle.textStyle?.resolve(const <MaterialState>{})?.fontSize ??
            14.0;
    final double effectiveTextScale =
        MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;

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
    // TODO: 删除弃用成员
    // ignore: deprecated_member_use
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    // Adjust the gap based on the text scale factor. Start at 8, and lerp
    // to 4 based on how large the text is.
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}

class _FilledTonalButtonDefaultsM3 extends ButtonStyle {
  _FilledTonalButtonDefaultsM3(this.context)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.secondaryContainer;
      });

  @override
  MaterialStateProperty<double>? get elevation =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return 0.0;
        }
        if (states.contains(MaterialState.pressed)) {
          return 0.0;
        }
        if (states.contains(MaterialState.hovered)) {
          return 1.0;
        }
        if (states.contains(MaterialState.focused)) {
          return 0.0;
        }
        return 0.0;
      });

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.onSecondaryContainer;
      });

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
      const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSecondaryContainer.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSecondaryContainer.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSecondaryContainer.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      MaterialStatePropertyAll<Color>(_colors.shadow);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
      const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      Theme.of(context).materialTapTargetSize;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
      MaterialStatePropertyAll<TextStyle?>(
          Theme.of(context).textTheme.labelLarge);

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;
}
