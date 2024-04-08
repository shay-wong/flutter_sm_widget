// ignore_for_file: deprecated_member_use

part of 'm_button.dart';

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
    super.isSelected,
    super.clearPadding,
    super.clearOverlay,
    super.clearSplash,
    required Widget icon,
    Widget? label,
    MButtonIconAlignment? alignment,
    double? space,
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

class _MButtonWithImage extends MButton {
  _MButtonWithImage({
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
    super.isSelected,
    super.clearPadding,
    super.clearOverlay,
    super.clearSplash,
    Widget? label,
    IconData? icon,
    Widget? image,
    String? source,
    MButtonIconAlignment? alignment,
    double? space,
  })  : alignment = alignment ?? MButtonIconAlignment.start,
        super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _MButtonWithImageChild(
            label: label,
            source: source,
            image: image,
            icon: icon,
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

class _MButtonWithImageChild extends StatelessWidget {
  const _MButtonWithImageChild({
    this.label,
    this.source,
    this.image,
    this.icon,
    this.space,
    this.alignment = MButtonIconAlignment.start,
  })  : assert(source != null || image != null || icon != null || label != null,
            'Must set one of source, image, icon, label'),
        assert(source == null || image == null || icon == null,
            'Cannot set more than one of source, image, icon');

  final MButtonIconAlignment alignment;
  final Widget? image;
  final String? source;
  final IconData? icon;
  final Widget? label;
  final double? space;

  @override
  Widget build(BuildContext context) {
    final result = image ?? (icon != null ? Icon(icon) : MImage(source));
    if (label == null) {
      return result;
    }
    final double scale = MediaQuery.textScalerOf(context).textScaleFactor;
    // [icon] 和 [label] 的默认间距
    final gap = alignment.isVertical ? 6.0 : 8.0;
    final double effectiveGap = space ??
        (scale <= 1 ? gap : lerpDouble(gap, gap / 2, math.min(scale - 1, 1))!);
    final effectiveIcon = Flexible(child: result);
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

class _MButtonWithText extends MButton {
  _MButtonWithText({
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
    super.isSemanticButton,
    super.isSelected,
    super.clearPadding,
    super.clearOverlay,
    super.clearSplash,
    String? data,
    Widget? text,
  })  : assert(data != null || text != null, 'Must set one of data, text'),
        assert(data == null || text == null,
            '`data` and `text` cannot be both null'),
        super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _MButtonWithTextChild(
            data: data,
            text: text,
          ),
        );
}

class _MButtonWithTextChild extends StatelessWidget {
  const _MButtonWithTextChild({
    this.text,
    this.data,
  });

  final String? data;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    return text ?? MText(data);
  }
}
