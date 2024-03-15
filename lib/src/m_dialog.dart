import 'dart:ui' show clampDouble, lerpDouble;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

class _MAdaptiveAlertDialog extends MAlertDialog {
  const _MAdaptiveAlertDialog({
    super.key,
    super.icon,
    super.iconPadding,
    super.iconColor,
    super.title,
    super.titlePadding,
    super.titleTextStyle,
    super.content,
    super.contentPadding,
    super.contentTextStyle,
    super.actions,
    super.actionsPadding,
    super.actionsAlignment,
    super.actionsOverflowAlignment,
    super.actionsOverflowDirection,
    super.actionsOverflowButtonSpacing,
    super.buttonPadding,
    super.backgroundColor,
    super.elevation,
    super.shadowColor,
    super.surfaceTintColor,
    super.semanticLabel,
    super.insetPadding = _defaultInsetPadding,
    super.clipBehavior = Clip.none,
    super.shape,
    super.alignment,
    super.scrollable = false,
    this.scrollController,
    this.actionScrollController,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
  });

  final ScrollController? actionScrollController;
  final Curve insetAnimationCurve;
  final Duration insetAnimationDuration;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions ?? <Widget>[],
          scrollController: scrollController,
          actionScrollController: actionScrollController,
          insetAnimationDuration: insetAnimationDuration,
          insetAnimationCurve: insetAnimationCurve,
        );
    }
    return super.build(context);
  }
}

class MAlertDialog extends StatelessWidget {
  const MAlertDialog({
    super.key,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticLabel,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.scrollable = false,
  });

  const factory MAlertDialog.adaptive({
    Key? key,
    Widget? icon,
    EdgeInsetsGeometry? iconPadding,
    Color? iconColor,
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleTextStyle,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? contentTextStyle,
    List<Widget>? actions,
    EdgeInsetsGeometry? actionsPadding,
    MainAxisAlignment? actionsAlignment,
    OverflowBarAlignment? actionsOverflowAlignment,
    VerticalDirection? actionsOverflowDirection,
    double? actionsOverflowButtonSpacing,
    EdgeInsetsGeometry? buttonPadding,
    Color? backgroundColor,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    String? semanticLabel,
    EdgeInsets insetPadding,
    Clip clipBehavior,
    ShapeBorder? shape,
    AlignmentGeometry? alignment,
    bool scrollable,
    ScrollController? scrollController,
    ScrollController? actionScrollController,
    Duration insetAnimationDuration,
    Curve insetAnimationCurve,
  }) = _MAdaptiveAlertDialog;

  final List<Widget>? actions;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final double? actionsOverflowButtonSpacing;
  final VerticalDirection? actionsOverflowDirection;
  final EdgeInsetsGeometry? actionsPadding;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? buttonPadding;
  final Clip clipBehavior;
  final Widget? content;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final double? elevation;
  final Widget? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final EdgeInsets insetPadding;
  final bool scrollable;
  final String? semanticLabel;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? surfaceTintColor;
  final Widget? title;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);

    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogTheme defaults = theme.useMaterial3 ? _MDialogDefaultsM3(context) : _MDialogDefaultsM2(context);

    String? label = semanticLabel;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label ??= MaterialLocalizations.of(context).alertDialogLabel;
    }
    // TODO: 删除弃用成员
    // The paddingScaleFactor is used to adjust the padding of Dialog's
    // children.
    // ignore: deprecated_member_use
    final double paddingScaleFactor = _paddingScaleFactor(MediaQuery.textScalerOf(context).textScaleFactor);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? iconWidget;
    Widget? titleWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    if (icon != null) {
      final bool belowIsTitle = title != null;
      final bool belowIsContent = !belowIsTitle && content != null;
      final EdgeInsets defaultIconPadding = EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        right: 24.0,
        bottom: belowIsTitle
            ? 16.0
            : belowIsContent
                ? 0.0
                : 24.0,
      );
      final EdgeInsets effectiveIconPadding = iconPadding?.resolve(textDirection) ?? defaultIconPadding;
      iconWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveIconPadding.left * paddingScaleFactor,
          right: effectiveIconPadding.right * paddingScaleFactor,
          top: effectiveIconPadding.top * paddingScaleFactor,
          bottom: effectiveIconPadding.bottom,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor ?? dialogTheme.iconColor ?? defaults.iconColor,
          ),
          child: icon!,
        ),
      );
    }

    if (title != null) {
      final EdgeInsets defaultTitlePadding = EdgeInsets.only(
        left: 24.0,
        top: icon == null ? 24.0 : 0.0,
        right: 24.0,
        bottom: content == null ? 20.0 : 0.0,
      );
      final EdgeInsets effectiveTitlePadding = titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: icon == null ? effectiveTitlePadding.top * paddingScaleFactor : effectiveTitlePadding.top,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style: titleTextStyle ?? dialogTheme.titleTextStyle ?? defaults.titleTextStyle!,
          textAlign: icon == null ? TextAlign.start : TextAlign.center,
          child: Semantics(
            // For iOS platform, the focus always lands on the title.
            // Set nameRoute to false to avoid title being announce twice.
            namesRoute: label == null && theme.platform != TargetPlatform.iOS,
            container: true,
            child: title,
          ),
        ),
      );
    }

    if (content != null) {
      final EdgeInsets defaultContentPadding = EdgeInsets.only(
        left: 24.0,
        top: theme.useMaterial3 ? 16.0 : 20.0,
        right: 24.0,
        bottom: 24.0,
      );
      final EdgeInsets effectiveContentPadding = contentPadding?.resolve(textDirection) ?? defaultContentPadding;
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: title == null && icon == null
              ? effectiveContentPadding.top * paddingScaleFactor
              : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: DefaultTextStyle(
          style: contentTextStyle ?? dialogTheme.contentTextStyle ?? defaults.contentTextStyle!,
          child: Semantics(
            container: true,
            child: content,
          ),
        ),
      );
    }

    if (actions != null) {
      final double spacing = (buttonPadding?.horizontal ?? 16) / 2;
      actionsWidget = Padding(
        padding: actionsPadding ??
            dialogTheme.actionsPadding ??
            (theme.useMaterial3 ? defaults.actionsPadding! : defaults.actionsPadding!.add(EdgeInsets.all(spacing))),
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.end,
          spacing: spacing,
          overflowAlignment: actionsOverflowAlignment ?? OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions!,
        ),
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (title != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (icon != null) iconWidget!,
                  if (title != null) titleWidget!,
                  if (content != null) contentWidget!,
                ],
              ),
            ),
          ),
        if (actions != null) actionsWidget!,
      ];
    } else {
      columnChildren = <Widget>[
        if (icon != null) iconWidget!,
        if (title != null) titleWidget!,
        if (content != null) Flexible(child: contentWidget!),
        if (actions != null) actionsWidget!,
      ];
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return MDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      alignment: alignment,
      child: dialogChild,
    );
  }
}

extension MAlertDialogExt on MAlertDialog {
  Future<T?> show<T>({
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return Get.dialog<T>(
      this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }
}

extension MDialogExt on MDialog {
  Future<T?> show<T>({
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return Get.dialog<T>(
      this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }

  static Future<T?> alert<T>({
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return const MAlertDialog().show(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }
}

class MDialog extends StatelessWidget {
  const MDialog({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.child,
  })  : assert(elevation == null || elevation >= 0.0),
        _fullscreen = false;

  const MDialog.fullscreen({
    super.key,
    this.backgroundColor,
    this.insetAnimationDuration = Duration.zero,
    this.insetAnimationCurve = Curves.decelerate,
    this.child,
  })  : elevation = 0,
        shadowColor = null,
        surfaceTintColor = null,
        insetPadding = EdgeInsets.zero,
        clipBehavior = Clip.none,
        shape = null,
        alignment = null,
        _fullscreen = true;

  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final Widget? child;
  final Clip clipBehavior;
  final double? elevation;
  final Curve insetAnimationCurve;
  final Duration insetAnimationDuration;
  final EdgeInsets? insetPadding;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? surfaceTintColor;

  final bool _fullscreen;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery.viewInsetsOf(context) + (insetPadding ?? EdgeInsets.zero);
    final DialogTheme defaults = theme.useMaterial3
        ? (_fullscreen ? _MDialogFullscreenDefaultsM3(context) : _MDialogDefaultsM3(context))
        : _MDialogDefaultsM2(context);

    Widget dialogChild;

    if (_fullscreen) {
      dialogChild = Material(
        color: backgroundColor ?? dialogTheme.backgroundColor ?? defaults.backgroundColor,
        child: child,
      );
    } else {
      dialogChild = Align(
        alignment: alignment ?? dialogTheme.alignment ?? defaults.alignment!,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280.0),
          child: Material(
            color: backgroundColor ?? dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
            elevation: elevation ?? dialogTheme.elevation ?? defaults.elevation!,
            shadowColor: shadowColor ?? dialogTheme.shadowColor ?? defaults.shadowColor,
            surfaceTintColor: surfaceTintColor ?? dialogTheme.surfaceTintColor ?? defaults.surfaceTintColor,
            shape: shape ?? dialogTheme.shape ?? defaults.shape!,
            type: MaterialType.card,
            clipBehavior: clipBehavior,
            child: child,
          ),
        ),
      );
    }

    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: dialogChild,
      ),
    );
  }
}

// Hand coded defaults based on Material Design 2.
class _MDialogDefaultsM2 extends DialogTheme {
  _MDialogDefaultsM2(this.context)
      : _textTheme = Theme.of(context).textTheme,
        _iconTheme = Theme.of(context).iconTheme,
        super(
          alignment: Alignment.center,
          elevation: 24.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        );

  final BuildContext context;

  final IconThemeData _iconTheme;
  final TextTheme _textTheme;

  @override
  EdgeInsetsGeometry? get actionsPadding => EdgeInsets.zero;

  @override
  Color? get backgroundColor => Theme.of(context).dialogBackgroundColor;

  @override
  TextStyle? get contentTextStyle => _textTheme.titleMedium;

  @override
  Color? get iconColor => _iconTheme.color;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;

  @override
  TextStyle? get titleTextStyle => _textTheme.titleLarge;
}

class _MDialogDefaultsM3 extends DialogTheme {
  _MDialogDefaultsM3(this.context)
      : super(
          alignment: Alignment.center,
          elevation: 6.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28.0))),
        );

  final BuildContext context;

  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  EdgeInsetsGeometry? get actionsPadding => const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0);

  @override
  Color? get backgroundColor => _colors.surface;

  @override
  TextStyle? get contentTextStyle => _textTheme.bodyMedium;

  @override
  Color? get iconColor => _colors.secondary;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => _colors.surfaceTint;

  @override
  TextStyle? get titleTextStyle => _textTheme.headlineSmall;
}

class _MDialogFullscreenDefaultsM3 extends DialogTheme {
  const _MDialogFullscreenDefaultsM3(this.context);

  final BuildContext context;

  @override
  Color? get backgroundColor => Theme.of(context).colorScheme.surface;
}

double _paddingScaleFactor(double textScaleFactor) {
  final double clampedTextScaleFactor = clampDouble(textScaleFactor, 1.0, 2.0);
  // The final padding scale factor is clamped between 1/3 and 1. For example,
  // a non-scaled padding of 24 will produce a padding between 24 and 8.
  return lerpDouble(1.0, 1.0 / 3.0, clampedTextScaleFactor - 1.0)!;
}
