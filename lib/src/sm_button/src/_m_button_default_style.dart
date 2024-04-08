part of 'm_button_style.dart';

extension _MButtonModeExt on MButtonMode {
  bool get isTextButton =>
      this == MButtonMode.text || this == MButtonMode.textIcon;

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
class _MButtonDefaultElevation extends MaterialStateProperty<double> {
  _MButtonDefaultElevation({
    required this.elevation,
    this.pressed,
    this.hovered,
    this.focused,
    this.disable,
  });

  final double? disable;
  final double elevation;
  final double? focused;
  final double? hovered;
  final double? pressed;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disable ?? elevation;
    }
    if (states.contains(MaterialState.pressed)) {
      return pressed ?? elevation;
    }
    if (states.contains(MaterialState.hovered)) {
      return hovered ?? elevation;
    }
    if (states.contains(MaterialState.focused)) {
      return focused ?? elevation;
    }
    return elevation;
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
class _MButtonDefaultOverlay implements MaterialStateProperty<Color?> {
  const _MButtonDefaultOverlay(
    this.primary,
    this.focus,
    this.hover,
    this.highlight,
    this.unselectedPrimary,
    this.unselectedFocus,
    this.unselectedHover,
    this.unselectedHighlight,
    this.selectedPrimary,
    this.selectedFocus,
    this.selectedHover,
    this.selectedHighlight,
    this.clearOverlay,
    this.toggleable,
    this.useMaterial3,
    this.mode,
  );

  final bool clearOverlay;
  final Color? focus;
  final Color? highlight;
  final Color? hover;
  final MButtonMode mode;
  final Color? primary;
  final Color? selectedFocus;
  final Color? selectedHighlight;
  final Color? selectedHover;
  final Color? selectedPrimary;
  final bool toggleable;
  final Color? unselectedFocus;
  final Color? unselectedHighlight;
  final Color? unselectedHover;
  final Color? unselectedPrimary;
  final bool useMaterial3;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (clearOverlay) {
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

    return mode.isIconButton ? Colors.transparent : null;
  }

  @override
  String toString() {
    final pressedOrFocusedOpacity = mode == MButtonMode.elevated ? 0.24 : 0.12;
    final hoveredOpacity = useMaterial3 ? 0.08 : 0.04;
    return '{hovered: ${hover ?? primary?.withOpacity(hoveredOpacity)}, focused: ${focus ?? primary?.withOpacity(pressedOrFocusedOpacity)}, pressed: ${highlight ?? primary?.withOpacity(pressedOrFocusedOpacity)}, otherwise: null}';
  }
}

@immutable
class _MButtonDefaultSide extends MaterialStateProperty<BorderSide?> {
  _MButtonDefaultSide(
    this.color,
    this.selected,
    this.focused,
    this.disable,
  );

  final Color? color;
  final Color? disable;
  final Color? focused;
  final Color? selected;

  @override
  BorderSide? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return selected == null ? null : BorderSide(color: selected!);
    }

    if (states.contains(MaterialState.disabled) && disable != null) {
      return BorderSide(color: disable!);
    }
    if (states.contains(MaterialState.focused) && focused != null) {
      return BorderSide(color: focused!);
    }
    return color == null ? null : BorderSide(color: color!);
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
