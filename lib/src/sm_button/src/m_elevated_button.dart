import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MElevatedButton extends ButtonStyleButton {
  const MElevatedButton({
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
  });

  factory MElevatedButton.icon({
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
  }) = _MElevatedButtonWithIcon;

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
    final Color? background = backgroundColor;
    final Color? disabledBackground = disabledBackgroundColor;
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (background == null && disabledBackground == null)
            ? null
            : _MElevatedButtonDefaultColor(background, disabledBackground);
    final Color? foreground = foregroundColor;
    final Color? disabledForeground = disabledForegroundColor;
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _MElevatedButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor = (foreground == null)
        ? null
        : _MElevatedButtonDefaultOverlay(foreground);
    final MaterialStateProperty<double>? elevationValue = (elevation == null)
        ? null
        : _MElevatedButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor?> mouseCursor =
        _MElevatedButtonDefaultMouseCursor(
            enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: elevationValue,
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

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Theme.of(context).useMaterial3
        ? _MElevatedButtonDefaultsM3(context)
        : styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
            disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
            shadowColor: theme.shadowColor,
            elevation: 2,
            textStyle: theme.textTheme.labelLarge,
            padding: _scaledPadding(context),
            minimumSize: const Size(64, 36),
            maximumSize: Size.infinite,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            enabledMouseCursor: SystemMouseCursors.click,
            disabledMouseCursor: SystemMouseCursors.basic,
            visualDensity: theme.visualDensity,
            tapTargetSize: theme.materialTapTargetSize,
            animationDuration: kThemeChangeDuration,
            enableFeedback: true,
            alignment: Alignment.center,
            splashFactory: InkRipple.splashFactory,
          );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return ElevatedButtonTheme.of(context).style;
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final double padding1x = theme.useMaterial3 ? 24.0 : 16.0;
  final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale =
      MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;

  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    effectiveTextScale,
  );
}

@immutable
class _MElevatedButtonDefaultColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _MElevatedButtonDefaultColor(this.color, this.disabled);

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
class _MElevatedButtonDefaultOverlay extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _MElevatedButtonDefaultOverlay(this.overlay);

  final Color overlay;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return overlay.withOpacity(0.24);
    }
    if (states.contains(MaterialState.hovered)) {
      return overlay.withOpacity(0.08);
    }
    if (states.contains(MaterialState.focused)) {
      return overlay.withOpacity(0.24);
    }
    return null;
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

@immutable
class _MElevatedButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _MElevatedButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor? enabledCursor;
  final MouseCursor? disabledCursor;

  @override
  MouseCursor? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

class _MElevatedButtonWithIcon extends MElevatedButton {
  _MElevatedButtonWithIcon({
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
          child: _MElevatedButtonWithIconChild(icon: icon, label: label),
        );

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

class _MElevatedButtonWithIconChild extends StatelessWidget {
  const _MElevatedButtonWithIconChild(
      {required this.label, required this.icon});

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    // TODO: 删除弃用成员
    // ignore: deprecated_member_use
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}

class _MElevatedButtonDefaultsM3 extends ButtonStyle {
  _MElevatedButtonDefaultsM3(this.context)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
      MaterialStatePropertyAll<TextStyle?>(
          Theme.of(context).textTheme.labelLarge);

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.surface;
      });

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.primary;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      MaterialStatePropertyAll<Color>(_colors.shadow);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      MaterialStatePropertyAll<Color>(_colors.surfaceTint);

  @override
  MaterialStateProperty<double>? get elevation =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return 0.0;
        }
        if (states.contains(MaterialState.pressed)) {
          return 1.0;
        }
        if (states.contains(MaterialState.hovered)) {
          return 3.0;
        }
        if (states.contains(MaterialState.focused)) {
          return 1.0;
        }
        return 1.0;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
      const MaterialStatePropertyAll<Size>(Size.infinite);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
      const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;
}
