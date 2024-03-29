// 修改自 flutter_expandable
// github: https://github.com/aryzhov/flutter-expandable
// pub.dev https://pub.dev/packages/expandable
// A library of Flutter widgets that allow creating expandable panels

import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef MExpandableBuilder = Widget Function(
    BuildContext context, Widget collapsed, Widget expanded);

/// Shows either the expanded or the collapsed child depending on the state.
/// The state is determined by an instance of [MExpandableController] provided by [ScopedModel]
class MExpandable extends StatelessWidget {
  /// Whe widget to show when collapsed
  final Widget collapsed;

  /// The widget to show when expanded
  final Widget expanded;

  /// If the controller is not specified, it will be retrieved from the context
  final MExpandableController? controller;

  final MExpandableThemeData? theme;

  const MExpandable({
    super.key,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ?? MExpandableController.of(context, required: true);
    final theme = MExpandableThemeData.withDefaults(this.theme, context);

    switch (theme.transition) {
      case MExpandableTransition.size:
        return AnimatedSize(
          duration: theme.animationDuration!,
          curve: theme.sizeCurve!,
          alignment: theme.alignment!,
          clipBehavior: theme.clipBehavior!,
          child: controller?.expanded ?? true ? expanded : collapsed,
        );
      case MExpandableTransition.opacity:
        return AnimatedOpacity(
          opacity: controller?.expanded ?? true ? 1.0 : 0.0,
          duration: theme.animationDuration!,
          curve: theme.fadeCurve!,
          child: controller?.expanded ?? true ? expanded : collapsed,
        );
      default:
        return AnimatedCrossFade(
          alignment: theme.alignment!,
          firstChild: collapsed,
          secondChild: expanded,
          firstCurve: Interval(theme.collapsedFadeStart, theme.collapsedFadeEnd,
              curve: theme.fadeCurve!),
          secondCurve: Interval(theme.expandedFadeStart, theme.expandedFadeEnd,
              curve: theme.fadeCurve!),
          sizeCurve: theme.sizeCurve!,
          crossFadeState: controller?.expanded ?? true
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: theme.animationDuration!,
        );
    }
  }
}

/// Toggles the state of [MExpandableController] when the user clicks on it.
class MExpandableButton extends StatelessWidget {
  final Widget? child;
  final MExpandableThemeData? theme;

  const MExpandableButton({super.key, this.child, this.theme});

  @override
  Widget build(BuildContext context) {
    final controller = MExpandableController.of(context, required: true);
    final theme = MExpandableThemeData.withDefaults(this.theme, context);

    if (theme.useInkWell!) {
      return InkWell(
        onTap: controller?.toggle,
        borderRadius: theme.inkWellBorderRadius!,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: controller?.toggle,
        child: child,
      );
    }
  }
}

/// Controls the state (expanded or collapsed) of one or more [Expandable].
/// The controller should be provided to [Expandable] via [MExpandableNotifier].
class MExpandableController extends ValueNotifier<bool> {
  MExpandableController({
    bool? initialExpanded,
  }) : super(initialExpanded ?? false);

  /// Returns [true] if the state is expanded, [false] if collapsed.
  bool get expanded => value;

  /// Sets the expanded state.
  set expanded(bool exp) {
    value = exp;
  }

  /// Sets the expanded state to the opposite of the current state.
  void toggle() {
    expanded = !expanded;
  }

  static MExpandableController? of(BuildContext context,
      {bool rebuildOnChange = true, bool required = false}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<
            _MExpandableControllerNotifier>()
        : context
            .findAncestorWidgetOfExactType<_MExpandableControllerNotifier>();
    assert(notifier != null || !required,
        "MExpandableNotifier is not found in widget tree");
    return notifier?.notifier;
  }
}

/// An down/up arrow icon that toggles the state of [MExpandableController] when the user clicks on it.
/// The model is accessed via [ScopedModelDescendant].
class MExpandableIcon extends StatefulWidget {
  final MExpandableThemeData? theme;

  const MExpandableIcon({
    super.key,
    this.theme,
    // ignore: deprecated_member_use_from_same_package
  });

  @override
  State<MExpandableIcon> createState() => _MExpandableIconState();
}

/// Makes an [MExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class MExpandableNotifier extends StatefulWidget {
  final MExpandableController? controller;
  final bool? initialExpanded;
  final Widget child;

  const MExpandableNotifier(
      {
      // An optional key
      super.key,

      /// If the controller is not provided, it's created with the initial value of `initialExpanded`.
      this.controller,

      /// Initial expanded state. Must not be used together with [controller].
      this.initialExpanded,

      /// The child can be any widget which contains [Expandable] widgets in its widget tree.
      required this.child})
      : assert(!(controller != null && initialExpanded != null));

  @override
  State<MExpandableNotifier> createState() => _MExpandableNotifierState();
}

/// A configurable widget for showing user-expandable content with an optional expand button.
class MExpandablePanel extends StatelessWidget {
  /// If specified, the header is always shown, and the expandable part is shown under the header
  final Widget? header;

  /// The widget shown in the collapsed state
  final Widget collapsed;

  /// The widget shown in the expanded state
  final Widget expanded;

  /// Builds an Expandable object, optional
  final MExpandableBuilder? builder;

  /// An optional controller. If not specified, a default controller will be
  /// obtained from a surrounding [MExpandableNotifier]. If that does not exist,
  /// the controller will be created with the initial state of [initialExpanded].
  final MExpandableController? controller;

  final MExpandableThemeData? theme;

  const MExpandablePanel({
    super.key,
    this.header,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.builder,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MExpandableThemeData.withDefaults(this.theme, context);

    Widget buildHeaderRow() {
      CrossAxisAlignment calculateHeaderCrossAxisAlignment() {
        switch (theme.headerAlignment!) {
          case MExpandablePanelHeaderAlignment.top:
            return CrossAxisAlignment.start;
          case MExpandablePanelHeaderAlignment.center:
            return CrossAxisAlignment.center;
          case MExpandablePanelHeaderAlignment.bottom:
            return CrossAxisAlignment.end;
        }
      }

      Widget wrapWithMExpandableButton(
          {required Widget? widget, required bool wrap}) {
        return wrap
            ? MExpandableButton(theme: theme, child: widget)
            : widget ?? Container();
      }

      if (!theme.hasIcon!) {
        return wrapWithMExpandableButton(
            widget: header, wrap: theme.tapHeaderToExpand!);
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: header ?? Container(),
          ),
          // ignore: deprecated_member_use_from_same_package
          wrapWithMExpandableButton(
              widget: MExpandableIcon(theme: theme),
              wrap: !theme.tapHeaderToExpand!)
        ];
        return wrapWithMExpandableButton(
            widget: Row(
              crossAxisAlignment: calculateHeaderCrossAxisAlignment(),
              children:
                  theme.iconPlacement! == MExpandablePanelIconPlacement.right
                      ? rowChildren
                      : rowChildren.reversed.toList(),
            ),
            wrap: theme.tapHeaderToExpand!);
      }
    }

    Widget buildBody() {
      Widget wrapBody(Widget child, bool tap) {
        Alignment calcAlignment() {
          switch (theme.bodyAlignment!) {
            case MExpandablePanelBodyAlignment.left:
              return Alignment.topLeft;
            case MExpandablePanelBodyAlignment.center:
              return Alignment.topCenter;
            case MExpandablePanelBodyAlignment.right:
              return Alignment.topRight;
          }
        }

        final widget = Align(
          alignment: calcAlignment(),
          child: child,
        );

        if (!tap) {
          return widget;
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: widget,
          onTap: () {
            final controller = MExpandableController.of(context);
            controller?.toggle();
          },
        );
      }

      final builder = this.builder ??
          (context, collapsed, expanded) {
            return MExpandable(
              collapsed: collapsed,
              expanded: expanded,
              theme: theme,
            );
          };

      return builder(context, wrapBody(collapsed, theme.tapBodyToExpand!),
          wrapBody(expanded, theme.tapBodyToCollapse!));
    }

    Widget buildWithHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeaderRow(),
          buildBody(),
        ],
      );
    }

    final panel = header != null ? buildWithHeader() : buildBody();

    if (controller != null) {
      return MExpandableNotifier(
        controller: controller,
        child: panel,
      );
    } else {
      final controller =
          MExpandableController.of(context, rebuildOnChange: false);
      if (controller == null) {
        return MExpandableNotifier(
          child: panel,
        );
      } else {
        return panel;
      }
    }
  }
}

/// Determines vertical alignment of the body
enum MExpandablePanelBodyAlignment {
  /// The body is positioned at the left
  left,

  /// The body is positioned in the center
  center,

  /// The body is positioned at the right
  right,
}

/// Determines the alignment of the header relative to the expand icon
enum MExpandablePanelHeaderAlignment {
  /// The header and the icon are aligned at their top positions
  top,

  /// The header and the icon are aligned at their center positions
  center,

  /// The header and the icon are aligned at their bottom positions
  bottom,
}

/// Determines the placement of the expand/collapse icon in [MExpandablePanel]
enum MExpandablePanelIconPlacement {
  /// The icon is on the left of the header
  left,

  /// The icon is on the right of the header
  right,
}

enum MExpandableTransition {
  fade,
  size,
  opacity,
}

class MExpandableTheme extends StatelessWidget {
  final MExpandableThemeData data;
  final Widget child;

  const MExpandableTheme({
    super.key,
    required this.data,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    _ExpandableThemeNotifier? n =
        context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>();
    return _ExpandableThemeNotifier(
      themeData: MExpandableThemeData.combine(data, n?.themeData),
      child: child,
    );
  }
}

class MExpandableThemeData {
  static const MExpandableThemeData defaults = MExpandableThemeData(
    iconColor: Colors.black54,
    useInkWell: true,
    inkWellBorderRadius: BorderRadius.zero,
    animationDuration: Duration(milliseconds: 300),
    scrollAnimationDuration: Duration(milliseconds: 300),
    crossFadePoint: 0.5,
    fadeCurve: Curves.linear,
    sizeCurve: Curves.fastOutSlowIn,
    alignment: Alignment.topLeft,
    headerAlignment: MExpandablePanelHeaderAlignment.top,
    bodyAlignment: MExpandablePanelBodyAlignment.left,
    iconPlacement: MExpandablePanelIconPlacement.right,
    tapHeaderToExpand: true,
    tapBodyToExpand: false,
    tapBodyToCollapse: false,
    hasIcon: true,
    iconSize: 24.0,
    iconPadding: EdgeInsets.all(8.0),
    iconRotationAngle: -math.pi,
    expandIcon: Icons.expand_more,
    collapseIcon: Icons.expand_more,
    transition: MExpandableTransition.fade,
    clipBehavior: Clip.hardEdge,
    opacityCurve: Curves.linear,
  );

  static const MExpandableThemeData empty = MExpandableThemeData();

  // Expand icon color.
  final Color? iconColor;

  // If true then [InkWell] will be used in the header for a ripple effect.
  final bool? useInkWell;

  // The duration of the transition between collapsed and expanded states.
  final Duration? animationDuration;

  // The duration of the scroll animation to make the expanded widget visible.
  final Duration? scrollAnimationDuration;

  /// The point in the cross-fade animation timeline (from 0 to 1)
  /// where the [collapsed] and [expanded] widgets are half-visible.
  ///
  /// If set to 0, the [expanded] widget will be shown immediately in full opacity
  /// when the size transition starts. This is useful if the collapsed widget is
  /// empty or if dealing with text that is shown partially in the collapsed state.
  /// This is the default value.
  ///
  /// If set to 0.5, the [expanded] and the [collapsed] widget will be shown
  /// at half of their opacity in the middle of the size animation with a
  /// cross-fade effect throughout the entire size transition.
  ///
  /// If set to 1, the [expanded] widget will be shown at the very end of the size animation.
  ///
  /// When collapsing, the effect of this setting is reversed. For example, if the value is 0
  /// then the [expanded] widget will remain to be shown until the end of the size animation.
  final double? crossFadePoint;

  /// The alignment of widgets during animation between expanded and collapsed states.
  final AlignmentGeometry? alignment;

  // Fade animation curve between expanded and collapsed states.
  final Curve? fadeCurve;

  // Size animation curve between expanded and collapsed states.
  final Curve? sizeCurve;

  // Opacity animation curve between expanded and collapsed states.
  final Curve? opacityCurve;

  // The alignment of the header for `MExpandablePanel`.
  final MExpandablePanelHeaderAlignment? headerAlignment;

  // The alignment of the body for `MExpandablePanel`.
  final MExpandablePanelBodyAlignment? bodyAlignment;

  /// Expand icon placement.
  final MExpandablePanelIconPlacement? iconPlacement;

  /// If true, the header of [MExpandablePanel] can be clicked by the user to expand or collapse.
  final bool? tapHeaderToExpand;

  /// If true, the body of [MExpandablePanel] can be clicked by the user to expand.
  final bool? tapBodyToExpand;

  /// If true, the body of [MExpandablePanel] can be clicked by the user to collapse.
  final bool? tapBodyToCollapse;

  /// If true, an icon is shown in the header of [MExpandablePanel].
  final bool? hasIcon;

  /// Expand icon size.
  final double? iconSize;

  /// Expand icon padding.
  final EdgeInsets? iconPadding;

  /// Icon rotation angle in clockwise radians. For example, specify `math.pi` to rotate the icon by 180 degrees
  /// clockwise when clicking on the expand button.
  final double? iconRotationAngle;

  /// The icon in the collapsed state.
  final IconData? expandIcon;

  /// The icon in the expanded state. If you specify the same icon as `expandIcon`, the `expandIcon` icon will
  /// be shown upside-down in the expanded state.
  final IconData? collapseIcon;

  ///The [BorderRadius] for the [InkWell], if `inkWell` is set to true
  final BorderRadius? inkWellBorderRadius;

  final MExpandableTransition? transition;
  final Clip? clipBehavior;

  const MExpandableThemeData({
    this.iconColor,
    this.useInkWell,
    this.animationDuration,
    this.scrollAnimationDuration,
    this.crossFadePoint,
    this.fadeCurve,
    this.sizeCurve,
    this.alignment,
    this.headerAlignment,
    this.bodyAlignment,
    this.iconPlacement,
    this.tapHeaderToExpand,
    this.tapBodyToExpand,
    this.tapBodyToCollapse,
    this.hasIcon,
    this.iconSize,
    this.iconPadding,
    this.iconRotationAngle,
    this.expandIcon,
    this.collapseIcon,
    this.inkWellBorderRadius,
    this.transition,
    this.clipBehavior,
    this.opacityCurve,
  });

  double get collapsedFadeEnd =>
      crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  double get collapsedFadeStart =>
      crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get expandedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  double get expandedFadeStart =>
      crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  @override
  int get hashCode {
    return 0; // we don't care
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is MExpandableThemeData) {
      return iconColor == other.iconColor &&
          useInkWell == other.useInkWell &&
          inkWellBorderRadius == other.inkWellBorderRadius &&
          animationDuration == other.animationDuration &&
          scrollAnimationDuration == other.scrollAnimationDuration &&
          crossFadePoint == other.crossFadePoint &&
          fadeCurve == other.fadeCurve &&
          sizeCurve == other.sizeCurve &&
          alignment == other.alignment &&
          headerAlignment == other.headerAlignment &&
          bodyAlignment == other.bodyAlignment &&
          iconPlacement == other.iconPlacement &&
          tapHeaderToExpand == other.tapHeaderToExpand &&
          tapBodyToExpand == other.tapBodyToExpand &&
          tapBodyToCollapse == other.tapBodyToCollapse &&
          hasIcon == other.hasIcon &&
          iconRotationAngle == other.iconRotationAngle &&
          expandIcon == other.expandIcon &&
          collapseIcon == other.collapseIcon &&
          transition == other.transition &&
          clipBehavior == other.clipBehavior &&
          opacityCurve == other.opacityCurve;
    } else {
      return false;
    }
  }

  bool isEmpty() {
    return this == empty;
  }

  bool isFull() {
    return iconColor != null &&
        useInkWell != null &&
        inkWellBorderRadius != null &&
        animationDuration != null &&
        scrollAnimationDuration != null &&
        crossFadePoint != null &&
        fadeCurve != null &&
        sizeCurve != null &&
        alignment != null &&
        headerAlignment != null &&
        bodyAlignment != null &&
        iconPlacement != null &&
        tapHeaderToExpand != null &&
        tapBodyToExpand != null &&
        tapBodyToCollapse != null &&
        hasIcon != null &&
        iconRotationAngle != null &&
        expandIcon != null &&
        collapseIcon != null &&
        transition != null &&
        clipBehavior != null &&
        opacityCurve != null;
  }

  MExpandableThemeData? nullIfEmpty() {
    return isEmpty() ? null : this;
  }

  static MExpandableThemeData combine(
      MExpandableThemeData? theme, MExpandableThemeData? defaults) {
    if (defaults == null || defaults.isEmpty()) {
      return theme ?? empty;
    } else if (theme == null || theme.isEmpty()) {
      return defaults;
    } else if (theme.isFull()) {
      return theme;
    } else {
      return MExpandableThemeData(
        iconColor: theme.iconColor ?? defaults.iconColor,
        useInkWell: theme.useInkWell ?? defaults.useInkWell,
        inkWellBorderRadius:
            theme.inkWellBorderRadius ?? defaults.inkWellBorderRadius,
        animationDuration:
            theme.animationDuration ?? defaults.animationDuration,
        scrollAnimationDuration:
            theme.scrollAnimationDuration ?? defaults.scrollAnimationDuration,
        crossFadePoint: theme.crossFadePoint ?? defaults.crossFadePoint,
        fadeCurve: theme.fadeCurve ?? defaults.fadeCurve,
        sizeCurve: theme.sizeCurve ?? defaults.sizeCurve,
        alignment: theme.alignment ?? defaults.alignment,
        headerAlignment: theme.headerAlignment ?? defaults.headerAlignment,
        bodyAlignment: theme.bodyAlignment ?? defaults.bodyAlignment,
        iconPlacement: theme.iconPlacement ?? defaults.iconPlacement,
        tapHeaderToExpand:
            theme.tapHeaderToExpand ?? defaults.tapHeaderToExpand,
        tapBodyToExpand: theme.tapBodyToExpand ?? defaults.tapBodyToExpand,
        tapBodyToCollapse:
            theme.tapBodyToCollapse ?? defaults.tapBodyToCollapse,
        hasIcon: theme.hasIcon ?? defaults.hasIcon,
        iconSize: theme.iconSize ?? defaults.iconSize,
        iconPadding: theme.iconPadding ?? defaults.iconPadding,
        iconRotationAngle:
            theme.iconRotationAngle ?? defaults.iconRotationAngle,
        expandIcon: theme.expandIcon ?? defaults.expandIcon,
        collapseIcon: theme.collapseIcon ?? defaults.collapseIcon,
        transition: theme.transition ?? defaults.transition,
        clipBehavior: theme.clipBehavior ?? defaults.clipBehavior,
        opacityCurve: theme.opacityCurve ?? defaults.opacityCurve,
      );
    }
  }

  MExpandableThemeData merge(MExpandableThemeData? other) {
    if (other == null || isFull()) return this;
    return copyWith(
      iconColor: other.iconColor,
      useInkWell: other.useInkWell,
      inkWellBorderRadius: other.inkWellBorderRadius,
      animationDuration: other.animationDuration,
      scrollAnimationDuration: other.scrollAnimationDuration,
      crossFadePoint: other.crossFadePoint,
      fadeCurve: other.fadeCurve,
      sizeCurve: other.sizeCurve,
      alignment: other.alignment,
      headerAlignment: other.headerAlignment,
      bodyAlignment: other.bodyAlignment,
      iconPlacement: other.iconPlacement,
      tapHeaderToExpand: other.tapHeaderToExpand,
      tapBodyToExpand: other.tapBodyToExpand,
      tapBodyToCollapse: other.tapBodyToCollapse,
      hasIcon: other.hasIcon,
      iconSize: other.iconSize,
      iconPadding: other.iconPadding,
      iconRotationAngle: other.iconRotationAngle,
      expandIcon: other.expandIcon,
      collapseIcon: other.collapseIcon,
      transition: other.transition,
      clipBehavior: other.clipBehavior,
      opacityCurve: other.opacityCurve,
    );
  }

  MExpandableThemeData copyWith({
    Color? iconColor,
    bool? useInkWell,
    Duration? animationDuration,
    Duration? scrollAnimationDuration,
    double? crossFadePoint,
    AlignmentGeometry? alignment,
    Curve? fadeCurve,
    Curve? sizeCurve,
    MExpandablePanelHeaderAlignment? headerAlignment,
    MExpandablePanelBodyAlignment? bodyAlignment,
    MExpandablePanelIconPlacement? iconPlacement,
    bool? tapHeaderToExpand,
    bool? tapBodyToExpand,
    bool? tapBodyToCollapse,
    bool? hasIcon,
    double? iconSize,
    EdgeInsets? iconPadding,
    double? iconRotationAngle,
    IconData? expandIcon,
    IconData? collapseIcon,
    BorderRadius? inkWellBorderRadius,
    MExpandableTransition? transition,
    Clip? clipBehavior,
    Curve? opacityCurve,
  }) {
    return MExpandableThemeData(
      iconColor: iconColor ?? this.iconColor,
      useInkWell: useInkWell ?? this.useInkWell,
      inkWellBorderRadius: inkWellBorderRadius ?? this.inkWellBorderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      scrollAnimationDuration:
          scrollAnimationDuration ?? this.scrollAnimationDuration,
      crossFadePoint: crossFadePoint ?? this.crossFadePoint,
      fadeCurve: fadeCurve ?? this.fadeCurve,
      sizeCurve: sizeCurve ?? this.sizeCurve,
      alignment: alignment ?? this.alignment,
      headerAlignment: headerAlignment ?? this.headerAlignment,
      bodyAlignment: bodyAlignment ?? this.bodyAlignment,
      iconPlacement: iconPlacement ?? this.iconPlacement,
      tapHeaderToExpand: tapHeaderToExpand ?? this.tapHeaderToExpand,
      tapBodyToExpand: tapBodyToExpand ?? this.tapBodyToExpand,
      tapBodyToCollapse: tapBodyToCollapse ?? this.tapBodyToCollapse,
      hasIcon: hasIcon ?? this.hasIcon,
      iconSize: iconSize ?? this.iconSize,
      iconPadding: iconPadding ?? this.iconPadding,
      iconRotationAngle: iconRotationAngle ?? this.iconRotationAngle,
      expandIcon: expandIcon ?? this.expandIcon,
      collapseIcon: collapseIcon ?? this.collapseIcon,
      transition: transition ?? this.transition,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      opacityCurve: opacityCurve ?? this.opacityCurve,
    );
  }

  static MExpandableThemeData of(BuildContext context,
      {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>()
        : context.findAncestorWidgetOfExactType<_ExpandableThemeNotifier>();
    return notifier?.themeData ?? defaults;
  }

  static MExpandableThemeData withDefaults(
      MExpandableThemeData? theme, BuildContext context,
      {bool rebuildOnChange = true}) {
    if (theme != null && theme.isFull()) {
      return theme;
    } else {
      return combine(
          combine(theme, of(context, rebuildOnChange: rebuildOnChange)),
          defaults);
    }
  }
}

/// Ensures that the child is visible on the screen by scrolling the outer viewport
/// when the outer [MExpandableNotifier] delivers a change event.
///
/// See also:
///
/// * [RenderObject.showOnScreen]
class MScrollOnExpand extends StatefulWidget {
  final Widget child;

  /// If true then the widget will be scrolled to become visible when expanded
  final bool scrollOnExpand;

  /// If true then the widget will be scrolled to become visible when collapsed
  final bool scrollOnCollapse;

  final MExpandableThemeData? theme;

  const MScrollOnExpand({
    super.key,
    required this.child,
    this.scrollOnExpand = true,
    this.scrollOnCollapse = true,
    this.theme,
  });

  @override
  State<MScrollOnExpand> createState() => _ScrollOnExpandState();
}

/// Makes an [MExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _MExpandableControllerNotifier
    extends InheritedNotifier<MExpandableController> {
  const _MExpandableControllerNotifier(
      {required MExpandableController? controller, required super.child})
      : super(notifier: controller);
}

class _MExpandableIconState extends State<MExpandableIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  MExpandableThemeData? theme;
  MExpandableController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = MExpandableThemeData.withDefaults(widget.theme, context);

    return Padding(
      padding: theme.iconPadding!,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, child) {
          final showSecondIcon = theme.collapseIcon! != theme.expandIcon! &&
              animationController!.value >= 0.5;
          return Transform.rotate(
            angle: theme.iconRotationAngle! *
                (showSecondIcon
                    ? -(1.0 - animationController!.value)
                    : animationController!.value),
            child: Icon(
              showSecondIcon ? theme.collapseIcon! : theme.expandIcon!,
              color: theme.iconColor!,
              size: theme.iconSize!,
            ),
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller2 = MExpandableController.of(context,
        rebuildOnChange: false, required: true);
    if (controller2 != controller) {
      controller?.removeListener(_expandedStateChanged);
      controller = controller2;
      controller?.addListener(_expandedStateChanged);
      if (controller?.expanded ?? true) {
        animationController!.value = 1.0;
      }
    }
  }

  @override
  void didUpdateWidget(MExpandableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      theme = null;
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_expandedStateChanged);
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final theme = MExpandableThemeData.withDefaults(widget.theme, context,
        rebuildOnChange: false);
    animationController =
        AnimationController(duration: theme.animationDuration, vsync: this);
    animation = animationController!.drive(Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: theme.sizeCurve!)));
    controller = MExpandableController.of(context,
        rebuildOnChange: false, required: true);
    controller?.addListener(_expandedStateChanged);
    if (controller?.expanded ?? true) {
      animationController!.value = 1.0;
    }
  }

  _expandedStateChanged() {
    if (controller!.expanded &&
        const [AnimationStatus.dismissed, AnimationStatus.reverse]
            .contains(animationController!.status)) {
      animationController!.forward();
    } else if (!controller!.expanded &&
        const [AnimationStatus.completed, AnimationStatus.forward]
            .contains(animationController!.status)) {
      animationController!.reverse();
    }
  }
}

class _MExpandableNotifierState extends State<MExpandableNotifier> {
  MExpandableController? controller;
  MExpandableThemeData? theme;

  @override
  Widget build(BuildContext context) {
    final cn = _MExpandableControllerNotifier(
        controller: controller, child: widget.child);
    return theme != null
        ? _ExpandableThemeNotifier(themeData: theme, child: cn)
        : cn;
  }

  @override
  void didUpdateWidget(MExpandableNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller &&
        widget.controller != null) {
      setState(() {
        controller = widget.controller;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        MExpandableController(initialExpanded: widget.initialExpanded ?? false);
  }
}

/// Makes an [MExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _ExpandableThemeNotifier extends InheritedWidget {
  final MExpandableThemeData? themeData;

  const _ExpandableThemeNotifier(
      {required this.themeData, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return !(oldWidget is _ExpandableThemeNotifier &&
        oldWidget.themeData == themeData);
  }
}

class _ScrollOnExpandState extends State<MScrollOnExpand> {
  MExpandableController? _controller;
  int _isAnimating = 0;
  BuildContext? _lastContext;
  MExpandableThemeData? _theme;

  Duration get _animationDuration {
    return _theme?.scrollAnimationDuration ??
        MExpandableThemeData.defaults.animationDuration!;
  }

  @override
  Widget build(BuildContext context) {
    _lastContext = context;
    _theme = MExpandableThemeData.withDefaults(widget.theme, context);
    return widget.child;
  }

  @override
  void didUpdateWidget(MScrollOnExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newController = MExpandableController.of(context,
        rebuildOnChange: false, required: true);
    if (newController != _controller) {
      _controller?.removeListener(_expandedStateChanged);
      _controller = newController;
      _controller?.addListener(_expandedStateChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_expandedStateChanged);
  }

  @override
  void initState() {
    super.initState();
    _controller = MExpandableController.of(context,
        rebuildOnChange: false, required: true);
    _controller?.addListener(_expandedStateChanged);
  }

  _animationComplete() {
    _isAnimating--;
    if (_isAnimating == 0 && _lastContext != null && mounted) {
      if ((_controller?.expanded ?? true && widget.scrollOnExpand) ||
          (!(_controller?.expanded ?? true) && widget.scrollOnCollapse)) {
        _lastContext
            ?.findRenderObject()
            ?.showOnScreen(duration: _animationDuration);
      }
    }
  }

  _expandedStateChanged() {
    if (_theme != null) {
      _isAnimating++;
      Future.delayed(_animationDuration + const Duration(milliseconds: 10),
          _animationComplete);
    }
  }
}
