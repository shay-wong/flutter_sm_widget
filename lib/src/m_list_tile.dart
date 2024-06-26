import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'sm_text/src/m_text.dart';

// Identifies the children of a _ListTileElement.
enum _ListTileSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _MIndividualOverrides extends MaterialStateProperty<Color?> {
  _MIndividualOverrides({
    this.explicitColor,
    this.enabledColor,
    this.selectedColor,
    this.disabledColor,
  });

  final Color? disabledColor;
  final Color? enabledColor;
  final Color? explicitColor;
  final Color? selectedColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (explicitColor is MaterialStateColor) {
      return MaterialStateProperty.resolveAs<Color?>(explicitColor, states);
    }
    if (states.contains(MaterialState.disabled)) {
      return disabledColor;
    }
    if (states.contains(MaterialState.selected)) {
      return selectedColor;
    }
    return enabledColor;
  }
}

class _MLisTileDefaultsM2 extends ListTileThemeData {
  _MLisTileDefaultsM2(this.context, ListTileStyle style, bool hasArrow)
      : super(
          contentPadding:
              EdgeInsets.symmetric(horizontal: hasArrow ? 8.0 : 16.0),
          minLeadingWidth: 40,
          minVerticalPadding: 4,
          shape: const Border(),
          style: style,
        );

  final BuildContext context;

  late final TextTheme _textTheme = _theme.textTheme;
  late final ThemeData _theme = Theme.of(context);

  @override
  Color? get iconColor {
    switch (_theme.brightness) {
      case Brightness.light:
        // For the sake of backwards compatibility, the default for unselected
        // tiles is Colors.black45 rather than colorScheme.onSurface.withAlpha(0x73).
        return Colors.black45;
      case Brightness.dark:
        return null; // null, Use current icon theme color
    }
  }

  @override
  TextStyle? get leadingAndTrailingTextStyle => _textTheme.bodyMedium;

  @override
  Color? get selectedColor => _theme.colorScheme.primary;

  @override
  TextStyle? get subtitleTextStyle =>
      _textTheme.bodyMedium!.copyWith(color: _textTheme.bodySmall!.color);

  @override
  Color? get tileColor => Colors.transparent;

  @override
  TextStyle? get titleTextStyle {
    switch (style!) {
      case ListTileStyle.drawer:
        return _textTheme.bodyLarge;
      case ListTileStyle.list:
        return _textTheme.titleMedium;
    }
  }
}

class _MLisTileDefaultsM3 extends ListTileThemeData {
  _MLisTileDefaultsM3(this.context, bool showArrow)
      : super(
          contentPadding: EdgeInsetsDirectional.only(
              start: 16.0,
              end: showArrow ? 8.0 : 16.0), // 原始默认为 24, 修改为 16, 有箭头时为 8
          minLeadingWidth: 24,
          minVerticalPadding: 8,
          shape: const RoundedRectangleBorder(),
        );

  final BuildContext context;

  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;
  late final ThemeData _theme = Theme.of(context);

  @override
  Color? get iconColor => _colors.onSurfaceVariant;

  @override
  TextStyle? get leadingAndTrailingTextStyle =>
      _textTheme.labelSmall!.copyWith(color: _colors.onSurfaceVariant);

  @override
  Color? get selectedColor => _colors.primary;

  @override
  TextStyle? get subtitleTextStyle =>
      _textTheme.bodyMedium!.copyWith(color: _colors.onSurfaceVariant);

  @override
  Color? get tileColor => Colors.transparent;

  @override
  TextStyle? get titleTextStyle =>
      _textTheme.bodyLarge!.copyWith(color: _colors.onSurface);
}

class MListTile extends StatelessWidget {
  const MListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    Color? tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.titleAlignment,
    Color? backgroundColor,
    String? titleText,
    double? height,
    double? tileHeight,
    double? macIconHeight,
    this.trailingOverride = true,
    String? detailText,
    this.showArrow = false,
    this.arrow,
  })  : tileColor = tileColor ?? backgroundColor,
        _titleText = titleText,
        _detailText = detailText,
        _tileHeight = tileHeight ?? height,
        _macIconHeight = macIconHeight ?? height,
        assert(!isThreeLine || subtitle != null);

  final Widget? arrow;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool? dense;
  final bool? enableFeedback;
  final bool enabled;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double? horizontalTitleGap;
  final Color? hoverColor;
  final Color? iconColor;
  final bool isThreeLine;
  final Widget? leading;
  final TextStyle? leadingAndTrailingTextStyle;
  final double? minLeadingWidth;
  final double? minVerticalPadding;
  final MouseCursor? mouseCursor;
  final ValueChanged<bool>? onFocusChange;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onTap;
  final bool selected;
  final Color? selectedColor;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final bool showArrow;
  final Color? splashColor;
  final ListTileStyle? style;
  final Widget? subtitle;
  final TextStyle? subtitleTextStyle;
  final Color? textColor;
  final Color? tileColor;
  final Widget? title;
  final ListTileTitleAlignment? titleAlignment;
  final TextStyle? titleTextStyle;
  final Widget? trailing;
  final VisualDensity? visualDensity;

  /// 默认 true 设置 [trailing] 会覆盖掉 [detail], 如果不覆盖, [trailing] 在 [detail] 的右边.
  final bool trailingOverride;

  final String? _detailText;
  final double? _macIconHeight;
  final double? _tileHeight;
  final String? _titleText;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<Widget>('leading', leading, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Widget>('title', title, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Widget>('subtitle', subtitle, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Widget>('trailing', trailing, defaultValue: null));
    properties.add(FlagProperty('isThreeLine',
        value: isThreeLine,
        ifTrue: 'THREE_LINE',
        ifFalse: 'TWO_LINE',
        showName: true,
        defaultValue: false));
    properties.add(FlagProperty('dense',
        value: dense, ifTrue: 'true', ifFalse: 'false', showName: true));
    properties.add(DiagnosticsProperty<VisualDensity>(
        'visualDensity', visualDensity,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(
        DiagnosticsProperty<ListTileStyle>('style', style, defaultValue: null));
    properties
        .add(ColorProperty('selectedColor', selectedColor, defaultValue: null));
    properties.add(ColorProperty('iconColor', iconColor, defaultValue: null));
    properties.add(ColorProperty('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'titleTextStyle', titleTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'subtitleTextStyle', subtitleTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'leadingAndTrailingTextStyle', leadingAndTrailingTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'contentPadding', contentPadding,
        defaultValue: null));
    properties.add(FlagProperty('enabled',
        value: enabled,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: true));
    properties
        .add(DiagnosticsProperty<Function>('onTap', onTap, defaultValue: null));
    properties.add(DiagnosticsProperty<Function>('onLongPress', onLongPress,
        defaultValue: null));
    properties.add(DiagnosticsProperty<MouseCursor>('mouseCursor', mouseCursor,
        defaultValue: null));
    properties.add(FlagProperty('selected',
        value: selected,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: false));
    properties.add(ColorProperty('focusColor', focusColor, defaultValue: null));
    properties.add(ColorProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode,
        defaultValue: null));
    properties.add(FlagProperty('autofocus',
        value: autofocus,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: false));
    properties.add(ColorProperty('tileColor', tileColor, defaultValue: null));
    properties.add(ColorProperty('selectedTileColor', selectedTileColor,
        defaultValue: null));
    properties.add(FlagProperty('enableFeedback',
        value: enableFeedback,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true));
    properties.add(DoubleProperty('horizontalTitleGap', horizontalTitleGap,
        defaultValue: null));
    properties.add(DoubleProperty('minVerticalPadding', minVerticalPadding,
        defaultValue: null));
    properties.add(
        DoubleProperty('minLeadingWidth', minLeadingWidth, defaultValue: null));
    properties.add(DiagnosticsProperty<ListTileTitleAlignment>(
        'titleAlignment', titleAlignment,
        defaultValue: null));
  }

  @protected
  Widget get _arrow =>
      arrow ??
      const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
        color: Colors.grey,
      );

  @protected
  Widget get _detail => MText(
        _detailText,
      );

  @protected
  Widget? get _trailing {
    Widget? finalTrailing;
    List<Widget> finalTrailings = [];
    if (trailingOverride) {
      if (trailing != null) {
        finalTrailings.add(trailing!);
      } else if (_detailText != null) {
        finalTrailings.add(_detail);
      }
    } else {
      if (_detailText != null && trailing == null) {
        finalTrailings.add(_detail);
      } else if (_detailText != null && trailing != null) {
        finalTrailings.addAll([_detail, const SizedBox(width: 8), trailing!]);
      } else if (_detailText == null && trailing != null) {
        finalTrailings.add(trailing!);
      }
    }

    if (onTap != null && showArrow) {
      if (finalTrailings.isNotEmpty) {
        finalTrailings.add(const SizedBox(width: 4));
      }
      finalTrailings.add(_arrow);
    }
    if (finalTrailings.isNotEmpty && finalTrailings.length > 1) {
      finalTrailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: finalTrailings,
      );
    } else if (finalTrailings.length == 1) {
      finalTrailing = finalTrailings.first;
    }
    return finalTrailing;
  }

  static Iterable<Widget> divideTiles(
      {BuildContext? context, required Iterable<Widget> tiles, Color? color}) {
    assert(color != null || context != null);
    tiles = tiles.toList();

    if (tiles.isEmpty || tiles.length == 1) {
      return tiles;
    }

    Widget wrapTile(Widget tile) {
      return DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, color: color),
          ),
        ),
        child: tile,
      );
    }

    return <Widget>[
      ...tiles.take(tiles.length - 1).map(wrapTile),
      tiles.last,
    ];
  }

  bool _isDenseLayout(ThemeData theme, ListTileThemeData tileTheme) {
    return dense ?? tileTheme.dense ?? theme.listTileTheme.dense ?? false;
  }

  Color _tileBackgroundColor(ThemeData theme, ListTileThemeData tileTheme,
      ListTileThemeData defaults) {
    final Color? color = selected
        ? selectedTileColor ??
            tileTheme.selectedTileColor ??
            theme.listTileTheme.selectedTileColor
        : tileColor ?? tileTheme.tileColor ?? theme.listTileTheme.tileColor;
    return color ?? defaults.tileColor!;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ListTileThemeData tileTheme = ListTileTheme.of(context);
    final ListTileStyle listTileStyle = style ??
        tileTheme.style ??
        theme.listTileTheme.style ??
        ListTileStyle.list;
    final ListTileThemeData defaults = theme.useMaterial3
        ? _MLisTileDefaultsM3(context, onTap != null && showArrow)
        : _MLisTileDefaultsM2(
            context, listTileStyle, onTap != null && showArrow);
    final Set<MaterialState> states = <MaterialState>{
      if (!enabled) MaterialState.disabled,
      if (selected) MaterialState.selected,
    };

    Color? resolveColor(
        Color? explicitColor, Color? selectedColor, Color? enabledColor,
        [Color? disabledColor]) {
      return _MIndividualOverrides(
        explicitColor: explicitColor,
        selectedColor: selectedColor,
        enabledColor: enabledColor,
        disabledColor: disabledColor,
      ).resolve(states);
    }

    final Color? effectiveIconColor =
        resolveColor(iconColor, selectedColor, iconColor) ??
            resolveColor(tileTheme.iconColor, tileTheme.selectedColor,
                tileTheme.iconColor) ??
            resolveColor(
                theme.listTileTheme.iconColor,
                theme.listTileTheme.selectedColor,
                theme.listTileTheme.iconColor) ??
            resolveColor(defaults.iconColor, defaults.selectedColor,
                defaults.iconColor, theme.disabledColor);
    final Color? effectiveColor =
        resolveColor(textColor, selectedColor, textColor) ??
            resolveColor(tileTheme.textColor, tileTheme.selectedColor,
                tileTheme.textColor) ??
            resolveColor(
                theme.listTileTheme.textColor,
                theme.listTileTheme.selectedColor,
                theme.listTileTheme.textColor) ??
            resolveColor(defaults.textColor, defaults.selectedColor,
                defaults.textColor, theme.disabledColor);
    final IconThemeData iconThemeData =
        IconThemeData(color: effectiveIconColor);
    final IconButtonThemeData iconButtonThemeData = IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: effectiveIconColor),
    );

    final effectiveTrailing = _trailing;

    TextStyle? leadingAndTrailingStyle;
    if (leading != null || effectiveTrailing != null) {
      leadingAndTrailingStyle = leadingAndTrailingTextStyle ??
          tileTheme.leadingAndTrailingTextStyle ??
          defaults.leadingAndTrailingTextStyle!;
      final Color? leadingAndTrailingTextColor = effectiveColor;
      leadingAndTrailingStyle =
          leadingAndTrailingStyle.copyWith(color: leadingAndTrailingTextColor);
    }

    Widget? leadingIcon;
    if (leading != null) {
      leadingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingStyle!,
        duration: kThemeChangeDuration,
        child: leading!,
      );
    }

    TextStyle titleStyle =
        titleTextStyle ?? tileTheme.titleTextStyle ?? defaults.titleTextStyle!;
    final Color? titleColor = effectiveColor;
    titleStyle = titleStyle.copyWith(
      color: titleColor,
      fontSize: _isDenseLayout(theme, tileTheme) ? 13.0 : null,
    );
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child:
          title ?? (_titleText == null ? const SizedBox() : MText(_titleText)),
    );

    Widget? subtitleText;
    TextStyle? subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = subtitleTextStyle ??
          tileTheme.subtitleTextStyle ??
          defaults.subtitleTextStyle!;
      final Color? subtitleColor = effectiveColor;
      subtitleStyle = subtitleStyle.copyWith(
        color: subtitleColor,
        fontSize: _isDenseLayout(theme, tileTheme) ? 12.0 : null,
      );
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: subtitle!,
      );
    }

    Widget? trailingIcon;
    if (effectiveTrailing != null) {
      trailingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingStyle!,
        duration: kThemeChangeDuration,
        child: effectiveTrailing,
      );
    }

    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding =
        contentPadding?.resolve(textDirection) ??
            tileTheme.contentPadding?.resolve(textDirection) ??
            defaults.contentPadding!.resolve(textDirection);

    // Show basic cursor when ListTile isn't enabled or gesture callbacks are null.
    final Set<MaterialState> mouseStates = <MaterialState>{
      if (!enabled || (onTap == null && onLongPress == null))
        MaterialState.disabled,
    };
    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor?>(
                mouseCursor, mouseStates) ??
            tileTheme.mouseCursor?.resolve(mouseStates) ??
            MaterialStateMouseCursor.clickable.resolve(mouseStates);

    final ListTileTitleAlignment effectiveTitleAlignment = titleAlignment ??
        tileTheme.titleAlignment ??
        (theme.useMaterial3
            ? ListTileTitleAlignment.threeLine
            : ListTileTitleAlignment.titleHeight);

    return InkWell(
      customBorder: shape ?? tileTheme.shape,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      onFocusChange: onFocusChange,
      mouseCursor: effectiveMouseCursor,
      canRequestFocus: enabled,
      focusNode: focusNode,
      focusColor: focusColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      autofocus: autofocus,
      enableFeedback: enableFeedback ?? tileTheme.enableFeedback ?? true,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: Ink(
          decoration: ShapeDecoration(
            shape: shape ?? tileTheme.shape ?? const Border(),
            color: _tileBackgroundColor(theme, tileTheme, defaults),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: IconTheme.merge(
              data: iconThemeData,
              child: IconButtonTheme(
                data: iconButtonThemeData,
                child: _MListTile(
                  leading: leadingIcon,
                  title: titleText,
                  subtitle: subtitleText,
                  trailing: trailingIcon,
                  isDense: _isDenseLayout(theme, tileTheme),
                  visualDensity: visualDensity ??
                      tileTheme.visualDensity ??
                      theme.visualDensity,
                  isThreeLine: isThreeLine,
                  textDirection: textDirection,
                  titleBaselineType: titleStyle.textBaseline ??
                      defaults.titleTextStyle!.textBaseline!,
                  subtitleBaselineType: subtitleStyle?.textBaseline ??
                      defaults.subtitleTextStyle!.textBaseline!,
                  horizontalTitleGap:
                      horizontalTitleGap ?? tileTheme.horizontalTitleGap ?? 16,
                  minVerticalPadding: minVerticalPadding ??
                      tileTheme.minVerticalPadding ??
                      defaults.minVerticalPadding!,
                  minLeadingWidth: minLeadingWidth ??
                      tileTheme.minLeadingWidth ??
                      defaults.minLeadingWidth!,
                  titleAlignment: effectiveTitleAlignment,
                  tileHeight: _tileHeight,
                  macIconHeight: _macIconHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MListTile
    extends SlottedMultiChildRenderObjectWidget<_ListTileSlot, RenderBox> {
  const _MListTile({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.isThreeLine,
    required this.isDense,
    required this.visualDensity,
    required this.textDirection,
    required this.titleBaselineType,
    required this.horizontalTitleGap,
    required this.minVerticalPadding,
    required this.minLeadingWidth,
    this.subtitleBaselineType,
    required this.titleAlignment,
    double? tileHeight,
    double? macIconHeight,
  })  : _tileHeight = tileHeight,
        _macIconHeight = macIconHeight;

  final double horizontalTitleGap;
  final bool isDense;
  final bool isThreeLine;
  final Widget? leading;
  final double minLeadingWidth;
  final double minVerticalPadding;
  final Widget? subtitle;
  final TextBaseline? subtitleBaselineType;
  final TextDirection textDirection;
  final Widget title;
  final ListTileTitleAlignment titleAlignment;
  final TextBaseline titleBaselineType;
  final Widget? trailing;
  final VisualDensity visualDensity;

  final double? _macIconHeight;
  final double? _tileHeight;

  @override
  Widget? childForSlot(_ListTileSlot slot) {
    switch (slot) {
      case _ListTileSlot.leading:
        return leading;
      case _ListTileSlot.title:
        return title;
      case _ListTileSlot.subtitle:
        return subtitle;
      case _ListTileSlot.trailing:
        return trailing;
    }
  }

  @override
  _MRenderListTile createRenderObject(BuildContext context) {
    return _MRenderListTile(
      isThreeLine: isThreeLine,
      isDense: isDense,
      visualDensity: visualDensity,
      textDirection: textDirection,
      titleBaselineType: titleBaselineType,
      subtitleBaselineType: subtitleBaselineType,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
      titleAlignment: titleAlignment,
      tileHeight: _tileHeight,
      macIconHeight: _macIconHeight,
    );
  }

  @override
  Iterable<_ListTileSlot> get slots => _ListTileSlot.values;

  @override
  void updateRenderObject(BuildContext context, _MRenderListTile renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..isDense = isDense
      ..visualDensity = visualDensity
      ..textDirection = textDirection
      ..titleBaselineType = titleBaselineType
      ..subtitleBaselineType = subtitleBaselineType
      ..horizontalTitleGap = horizontalTitleGap
      ..minLeadingWidth = minLeadingWidth
      ..minVerticalPadding = minVerticalPadding
      ..titleAlignment = titleAlignment;
  }
}

class _MRenderListTile extends RenderBox
    with SlottedContainerRenderObjectMixin<_ListTileSlot, RenderBox> {
  _MRenderListTile({
    required bool isDense,
    required VisualDensity visualDensity,
    required bool isThreeLine,
    required TextDirection textDirection,
    required TextBaseline titleBaselineType,
    TextBaseline? subtitleBaselineType,
    required double horizontalTitleGap,
    required double minVerticalPadding,
    required double minLeadingWidth,
    required ListTileTitleAlignment titleAlignment,
    double? tileHeight,
    double? macIconHeight,
  })  : _isDense = isDense,
        _visualDensity = visualDensity,
        _isThreeLine = isThreeLine,
        _textDirection = textDirection,
        _titleBaselineType = titleBaselineType,
        _subtitleBaselineType = subtitleBaselineType,
        _horizontalTitleGap = horizontalTitleGap,
        _minVerticalPadding = minVerticalPadding,
        _minLeadingWidth = minLeadingWidth,
        _titleAlignment = titleAlignment,
        _tileHeight = tileHeight,
        _macIconHeight = macIconHeight;

  final double? _macIconHeight;
  final double? _tileHeight;

  double _horizontalTitleGap;
  bool _isDense;
  bool _isThreeLine;
  double _minLeadingWidth;
  double _minVerticalPadding;
  TextDirection _textDirection;
  ListTileTitleAlignment _titleAlignment;
  TextBaseline _titleBaselineType;
  VisualDensity _visualDensity;

  TextBaseline? _subtitleBaselineType;

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (leading != null) leading!,
      if (title != null) title!,
      if (subtitle != null) subtitle!,
      if (trailing != null) trailing!,
    ];
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(title != null);
    final BoxParentData parentData = title!.parentData! as BoxParentData;
    return parentData.offset.dy + title!.getDistanceToActualBaseline(baseline)!;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason:
          'Layout requires baseline metrics, which are only available after a full layout.',
    ));
    return Size.zero;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading!.getMaxIntrinsicWidth(height), _minLeadingWidth) +
            _effectiveHorizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_maxWidth(title, height), _maxWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      _defaultTileHeight,
      title!.getMinIntrinsicHeight(width) +
          (subtitle?.getMinIntrinsicHeight(width) ?? 0.0),
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading!.getMinIntrinsicWidth(height), _minLeadingWidth) +
            _effectiveHorizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_minWidth(title, height), _minWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData! as BoxParentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }

    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  // All of the dimensions below were taken from the Material Design spec:
  // https://material.io/design/components/lists.html#specs
  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final bool hasLeading = leading != null;
    final bool hasSubtitle = subtitle != null;
    final bool hasTrailing = trailing != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;
    final Offset densityAdjustment = visualDensity.baseSizeAdjustment;

    final BoxConstraints maxIconHeightConstraint = BoxConstraints(
      // One-line trailing and leading widget heights do not follow
      // Material specifications, but this sizing is required to adhere
      // to accessibility requirements for smallest tappable widget.
      // Two- and three-line trailing widget heights are constrained
      // properly according to the Material spec.
      maxHeight:
          (_macIconHeight ?? (isDense ? 48.0 : 56.0)) + densityAdjustment.dy,
    );
    final BoxConstraints looseConstraints = constraints.loosen();
    final BoxConstraints iconConstraints =
        looseConstraints.enforce(maxIconHeightConstraint);

    final double tileWidth = looseConstraints.maxWidth;
    final Size leadingSize = _layoutBox(leading, iconConstraints);
    final Size trailingSize = _layoutBox(trailing, iconConstraints);
    assert(
      tileWidth != leadingSize.width || tileWidth == 0.0,
      'Leading widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );
    assert(
      tileWidth != trailingSize.width || tileWidth == 0.0,
      'Trailing widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );

    final double titleStart = hasLeading
        ? math.max(_minLeadingWidth, leadingSize.width) +
            _effectiveHorizontalTitleGap
        : 0.0;
    final double adjustedTrailingWidth = hasTrailing
        ? math.max(trailingSize.width + _effectiveHorizontalTitleGap, 32.0)
        : 0.0;
    final BoxConstraints textConstraints = looseConstraints.tighten(
      width: tileWidth - titleStart - adjustedTrailingWidth,
    );
    final Size titleSize = _layoutBox(title, textConstraints);
    final Size subtitleSize = _layoutBox(subtitle, textConstraints);

    double? titleBaseline;
    double? subtitleBaseline;
    if (isTwoLine) {
      titleBaseline = isDense ? 28.0 : 32.0;
      subtitleBaseline = isDense ? 48.0 : 52.0;
    } else if (isThreeLine) {
      titleBaseline = isDense ? 22.0 : 28.0;
      subtitleBaseline = isDense ? 42.0 : 48.0;
    } else {
      assert(isOneLine);
    }

    final double defaultTileHeight = _tileHeight ?? _defaultTileHeight;

    double tileHeight;
    double titleY;
    double? subtitleY;
    if (!hasSubtitle) {
      tileHeight = math.max(
          defaultTileHeight, titleSize.height + 2.0 * _minVerticalPadding);
      titleY = (tileHeight - titleSize.height) / 2.0;
    } else {
      assert(subtitleBaselineType != null);
      titleY = titleBaseline! - _boxBaseline(title!, titleBaselineType)!;
      subtitleY = subtitleBaseline! -
          _boxBaseline(subtitle!, subtitleBaselineType!)! +
          visualDensity.vertical * 2.0;
      tileHeight = defaultTileHeight;

      // If the title and subtitle overlap, move the title upwards by half
      // the overlap and the subtitle down by the same amount, and adjust
      // tileHeight so that both titles fit.
      final double titleOverlap = titleY + titleSize.height - subtitleY;
      if (titleOverlap > 0.0) {
        titleY -= titleOverlap / 2.0;
        subtitleY += titleOverlap / 2.0;
      }

      // If the title or subtitle overflow tileHeight then punt: title
      // and subtitle are arranged in a column, tileHeight = column height plus
      // _minVerticalPadding on top and bottom.
      if (titleY < _minVerticalPadding ||
          (subtitleY + subtitleSize.height + _minVerticalPadding) >
              tileHeight) {
        tileHeight =
            titleSize.height + subtitleSize.height + 2.0 * _minVerticalPadding;
        titleY = _minVerticalPadding;
        subtitleY = titleSize.height + _minVerticalPadding;
      }
    }

    final double leadingY;
    final double trailingY;

    switch (titleAlignment) {
      case ListTileTitleAlignment.threeLine:
        {
          if (isThreeLine) {
            leadingY = _minVerticalPadding;
            trailingY = _minVerticalPadding;
          } else {
            leadingY = (tileHeight - leadingSize.height) / 2.0;
            trailingY = (tileHeight - trailingSize.height) / 2.0;
          }
          break;
        }
      case ListTileTitleAlignment.titleHeight:
        {
          // This attempts to implement the redlines for the vertical position of the
          // leading and trailing icons on the spec page:
          //   https://m2.material.io/components/lists#specs
          // The interpretation for these redlines is as follows:
          //  - For large tiles (> 72dp), both leading and trailing controls should be
          //    a fixed distance from top. As per guidelines this is set to 16dp.
          //  - For smaller tiles, trailing should always be centered. Leading can be
          //    centered or closer to the top. It should never be further than 16dp
          //    to the top.
          if (tileHeight > 72.0) {
            leadingY = 16.0;
            trailingY = 16.0;
          } else {
            leadingY = math.min((tileHeight - leadingSize.height) / 2.0, 16.0);
            trailingY = (tileHeight - trailingSize.height) / 2.0;
          }
          break;
        }
      case ListTileTitleAlignment.top:
        {
          leadingY = _minVerticalPadding;
          trailingY = _minVerticalPadding;
          break;
        }
      case ListTileTitleAlignment.center:
        {
          leadingY = (tileHeight - leadingSize.height) / 2.0;
          trailingY = (tileHeight - trailingSize.height) / 2.0;
          break;
        }
      case ListTileTitleAlignment.bottom:
        {
          leadingY = tileHeight - leadingSize.height - _minVerticalPadding;
          trailingY = tileHeight - trailingSize.height - _minVerticalPadding;
          break;
        }
    }

    switch (textDirection) {
      case TextDirection.rtl:
        {
          if (hasLeading) {
            _positionBox(
                leading!, Offset(tileWidth - leadingSize.width, leadingY));
          }
          _positionBox(title!, Offset(adjustedTrailingWidth, titleY));
          if (hasSubtitle) {
            _positionBox(subtitle!, Offset(adjustedTrailingWidth, subtitleY!));
          }
          if (hasTrailing) {
            _positionBox(trailing!, Offset(0.0, trailingY));
          }
          break;
        }
      case TextDirection.ltr:
        {
          if (hasLeading) {
            _positionBox(leading!, Offset(0.0, leadingY));
          }
          _positionBox(title!, Offset(titleStart, titleY));
          if (hasSubtitle) {
            _positionBox(subtitle!, Offset(titleStart, subtitleY!));
          }
          if (hasTrailing) {
            _positionBox(
                trailing!, Offset(tileWidth - trailingSize.width, trailingY));
          }
          break;
        }
    }

    size = constraints.constrain(Size(tileWidth, tileHeight));
    assert(size.width == constraints.constrainWidth(tileWidth));
    assert(size.height == constraints.constrainHeight(tileHeight));
  }

  @override
  bool get sizedByParent => false;

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    final Offset baseDensity = visualDensity.baseSizeAdjustment;
    if (isOneLine) {
      return (isDense ? 48.0 : 56.0) + baseDensity.dy;
    }
    if (isTwoLine) {
      return (isDense ? 64.0 : 72.0) + baseDensity.dy;
    }
    return (isDense ? 76.0 : 88.0) + baseDensity.dy;
  }

  double get _effectiveHorizontalTitleGap =>
      _horizontalTitleGap + visualDensity.horizontal * 2.0;
  double get horizontalTitleGap => _horizontalTitleGap;
  bool get isDense => _isDense;
  bool get isThreeLine => _isThreeLine;
  RenderBox? get leading => childForSlot(_ListTileSlot.leading);
  double get minLeadingWidth => _minLeadingWidth;
  double get minVerticalPadding => _minVerticalPadding;
  RenderBox? get subtitle => childForSlot(_ListTileSlot.subtitle);
  TextBaseline? get subtitleBaselineType => _subtitleBaselineType;
  TextDirection get textDirection => _textDirection;
  RenderBox? get title => childForSlot(_ListTileSlot.title);
  ListTileTitleAlignment get titleAlignment => _titleAlignment;
  TextBaseline get titleBaselineType => _titleBaselineType;
  RenderBox? get trailing => childForSlot(_ListTileSlot.trailing);
  VisualDensity get visualDensity => _visualDensity;

  set horizontalTitleGap(double value) {
    if (_horizontalTitleGap == value) {
      return;
    }
    _horizontalTitleGap = value;
    markNeedsLayout();
  }

  set isDense(bool value) {
    if (_isDense == value) {
      return;
    }
    _isDense = value;
    markNeedsLayout();
  }

  set isThreeLine(bool value) {
    if (_isThreeLine == value) {
      return;
    }
    _isThreeLine = value;
    markNeedsLayout();
  }

  set minLeadingWidth(double value) {
    if (_minLeadingWidth == value) {
      return;
    }
    _minLeadingWidth = value;
    markNeedsLayout();
  }

  set minVerticalPadding(double value) {
    if (_minVerticalPadding == value) {
      return;
    }
    _minVerticalPadding = value;
    markNeedsLayout();
  }

  set subtitleBaselineType(TextBaseline? value) {
    if (_subtitleBaselineType == value) {
      return;
    }
    _subtitleBaselineType = value;
    markNeedsLayout();
  }

  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  set titleAlignment(ListTileTitleAlignment value) {
    if (_titleAlignment == value) {
      return;
    }
    _titleAlignment = value;
    markNeedsLayout();
  }

  set titleBaselineType(TextBaseline value) {
    if (_titleBaselineType == value) {
      return;
    }
    _titleBaselineType = value;
    markNeedsLayout();
  }

  set visualDensity(VisualDensity value) {
    if (_visualDensity == value) {
      return;
    }
    _visualDensity = value;
    markNeedsLayout();
  }

  static double? _boxBaseline(RenderBox box, TextBaseline baseline) {
    return box.getDistanceToBaseline(baseline);
  }

  static Size _layoutBox(RenderBox? box, BoxConstraints constraints) {
    if (box == null) {
      return Size.zero;
    }
    box.layout(constraints, parentUsesSize: true);
    return box.size;
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData! as BoxParentData;
    parentData.offset = offset;
  }
}
