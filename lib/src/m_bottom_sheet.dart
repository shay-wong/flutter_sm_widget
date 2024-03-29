import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const Duration _bottomSheetEnterDuration = Duration(milliseconds: 250);
const Duration _bottomSheetExitDuration = Duration(milliseconds: 200);
const Curve _modalBottomSheetCurve = decelerateEasing;
const double _minFlingVelocity = 700.0;
const double _closeProgressThreshold = 0.5;
const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

class MBottomSheet extends StatefulWidget {
  const MBottomSheet({
    super.key,
    this.animationController,
    this.enableDrag = true,
    this.showDragHandle,
    this.dragHandleColor,
    this.dragHandleSize,
    this.onDragStart,
    this.onDragEnd,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.onClosing,
    this.builder,
    this.child,
  }) : assert(elevation == null || elevation >= 0.0);

  final AnimationController? animationController;
  final Color? backgroundColor;
  final WidgetBuilder? builder;
  final Widget? child;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? dragHandleColor;
  final Size? dragHandleSize;
  final double? elevation;
  final bool enableDrag;
  final VoidCallback? onClosing;
  final BottomSheetDragEndHandler? onDragEnd;
  final BottomSheetDragStartHandler? onDragStart;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final bool? showDragHandle;

  @override
  State<MBottomSheet> createState() => _MBottomSheetState();

  static AnimationController createAnimationController(TickerProvider vsync) {
    return AnimationController(
      duration: _bottomSheetEnterDuration,
      reverseDuration: _bottomSheetExitDuration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class _MBottomSheetDefaultsM3 extends BottomSheetThemeData {
  _MBottomSheetDefaultsM3(this.context)
      : super(
          elevation: 1.0,
          modalElevation: 1.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.0))),
          constraints: const BoxConstraints(maxWidth: 640),
        );

  final BuildContext context;

  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get backgroundColor => _colors.surface;

  @override
  BoxConstraints? get constraints => const BoxConstraints(maxWidth: 640.0);

  @override
  Color? get dragHandleColor => _colors.onSurfaceVariant.withOpacity(0.4);

  @override
  Size? get dragHandleSize => const Size(32, 4);

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => _colors.surfaceTint;
}

// PERSISTENT BOTTOM SHEETS

// See scaffold.dart

typedef _SizeChangeCallback<Size> = void Function(Size size);

class _MBottomSheetGestureDetector extends StatelessWidget {
  const _MBottomSheetGestureDetector({
    required this.child,
    required this.onVerticalDragStart,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
  });

  final Widget child;
  final GestureDragEndCallback onVerticalDragEnd;
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      excludeFromSemantics: true,
      gestures: <Type, GestureRecognizerFactory<GestureRecognizer>>{
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(debugOwner: this),
          (VerticalDragGestureRecognizer instance) {
            instance
              ..onStart = onVerticalDragStart
              ..onUpdate = onVerticalDragUpdate
              ..onEnd = onVerticalDragEnd
              ..onlyAcceptDragOnThreshold = true;
          },
        ),
      },
      child: child,
    );
  }
}

class _MBottomSheetLayoutWithSizeListener
    extends SingleChildRenderObjectWidget {
  const _MBottomSheetLayoutWithSizeListener({
    required this.onChildSizeChanged,
    required this.animationValue,
    required this.isScrollControlled,
    required this.scrollControlDisabledMaxHeightRatio,
    super.child,
  });

  final double animationValue;
  final bool isScrollControlled;
  final _SizeChangeCallback<Size> onChildSizeChanged;
  final double scrollControlDisabledMaxHeightRatio;

  @override
  _MRenderBottomSheetLayoutWithSizeListener createRenderObject(
      BuildContext context) {
    return _MRenderBottomSheetLayoutWithSizeListener(
      onChildSizeChanged: onChildSizeChanged,
      animationValue: animationValue,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      _MRenderBottomSheetLayoutWithSizeListener renderObject) {
    renderObject.onChildSizeChanged = onChildSizeChanged;
    renderObject.animationValue = animationValue;
    renderObject.isScrollControlled = isScrollControlled;
    renderObject.scrollControlDisabledMaxHeightRatio =
        scrollControlDisabledMaxHeightRatio;
  }
}

class _MBottomSheetState extends State<MBottomSheet> {
  Set<MaterialState> dragHandleMaterialState = <MaterialState>{};

  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  double get _childHeight {
    final RenderBox renderBox =
        _childKey.currentContext!.findRenderObject()! as RenderBox;
    return renderBox.size.height;
  }

  bool get _dismissUnderway =>
      widget.animationController!.status == AnimationStatus.reverse;

  bool extentChanged(DraggableScrollableNotification notification) {
    if (notification.extent == notification.minExtent &&
        notification.shouldCloseOnMinExtent) {
      widget.onClosing?.call();
    }
    return false;
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(
      (widget.enableDrag || (widget.showDragHandle ?? false)) &&
          widget.animationController != null,
      "'BottomSheet.animationController' cannot be null when 'BottomSheet.enableDrag' or 'BottomSheet.showDragHandle' is true. "
      "Use 'BottomSheet.createAnimationController' to create one, or provide another AnimationController.",
    );
    if (_dismissUnderway) {
      return;
    }
    setState(() {
      dragHandleMaterialState.remove(MaterialState.dragged);
    });
    bool isClosing = false;
    if (details.velocity.pixelsPerSecond.dy > _minFlingVelocity) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (widget.animationController!.value > 0.0) {
        widget.animationController!.fling(velocity: flingVelocity);
      }
      if (flingVelocity < 0.0) {
        isClosing = true;
      }
    } else if (widget.animationController!.value < _closeProgressThreshold) {
      if (widget.animationController!.value > 0.0) {
        widget.animationController!.fling(velocity: -1.0);
      }
      isClosing = true;
    } else {
      widget.animationController!.forward();
    }

    widget.onDragEnd?.call(
      details,
      isClosing: isClosing,
    );

    if (isClosing) {
      widget.onClosing?.call();
    }
  }

  void _handleDragHandleHover(bool hovering) {
    if (hovering != dragHandleMaterialState.contains(MaterialState.hovered)) {
      setState(() {
        if (hovering) {
          dragHandleMaterialState.add(MaterialState.hovered);
        } else {
          dragHandleMaterialState.remove(MaterialState.hovered);
        }
      });
    }
  }

  void _handleDragStart(DragStartDetails details) {
    setState(() {
      dragHandleMaterialState.add(MaterialState.dragged);
    });
    widget.onDragStart?.call(details);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(
      (widget.enableDrag || (widget.showDragHandle ?? false)) &&
          widget.animationController != null,
      "'BottomSheet.animationController' cannot be null when 'BottomSheet.enableDrag' or 'BottomSheet.showDragHandle' is true. "
      "Use 'BottomSheet.createAnimationController' to create one, or provide another AnimationController.",
    );
    if (_dismissUnderway) {
      return;
    }
    widget.animationController!.value -= details.primaryDelta! / _childHeight;
  }

  @override
  Widget build(BuildContext context) {
    final BottomSheetThemeData bottomSheetTheme =
        Theme.of(context).bottomSheetTheme;
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    final BottomSheetThemeData defaults = useMaterial3
        ? _MBottomSheetDefaultsM3(context)
        : const BottomSheetThemeData();
    final BoxConstraints? constraints = widget.constraints ??
        bottomSheetTheme.constraints ??
        defaults.constraints;
    final Color? color = widget.backgroundColor ??
        bottomSheetTheme.backgroundColor ??
        defaults.backgroundColor;
    final Color? surfaceTintColor =
        bottomSheetTheme.surfaceTintColor ?? defaults.surfaceTintColor;
    final Color? shadowColor = widget.shadowColor ??
        bottomSheetTheme.shadowColor ??
        defaults.shadowColor;
    final double elevation = widget.elevation ??
        bottomSheetTheme.elevation ??
        defaults.elevation ??
        0;
    final ShapeBorder? shape =
        widget.shape ?? bottomSheetTheme.shape ?? defaults.shape;
    final Clip clipBehavior =
        widget.clipBehavior ?? bottomSheetTheme.clipBehavior ?? Clip.none;
    final bool showDragHandle = widget.showDragHandle ??
        (widget.enableDrag && (bottomSheetTheme.showDragHandle ?? false));

    Widget? dragHandle;
    if (showDragHandle) {
      dragHandle = _MDragHandle(
        onSemanticsTap: widget.onClosing,
        handleHover: _handleDragHandleHover,
        materialState: dragHandleMaterialState,
        dragHandleColor: widget.dragHandleColor,
        dragHandleSize: widget.dragHandleSize,
      );
      // Only add [_MBottomSheetGestureDetector] to the drag handle when the rest of the
      // bottom sheet is not draggable. If the whole bottom sheet is draggable,
      // no need to add it.
      if (!widget.enableDrag) {
        dragHandle = _MBottomSheetGestureDetector(
          onVerticalDragStart: _handleDragStart,
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          child: dragHandle,
        );
      }
    }

    Widget bottomSheet = Material(
      key: _childKey,
      color: color,
      elevation: elevation,
      surfaceTintColor: surfaceTintColor,
      shadowColor: shadowColor,
      shape: shape,
      clipBehavior: clipBehavior,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: extentChanged,
        child: !showDragHandle
            ? widget.builder?.call(context) ??
                widget.child ??
                const SizedBox.shrink()
            : Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  dragHandle!,
                  Padding(
                    padding:
                        const EdgeInsets.only(top: kMinInteractiveDimension),
                    child: widget.builder?.call(context) ?? widget.child,
                  ),
                ],
              ),
      ),
    );

    if (constraints != null) {
      bottomSheet = Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: constraints,
          child: bottomSheet,
        ),
      );
    }

    return !widget.enableDrag
        ? bottomSheet
        : _MBottomSheetGestureDetector(
            onVerticalDragStart: _handleDragStart,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: bottomSheet,
          );
  }
}

// TODO(guidezpl): Look into making this public. A copy of this class is in
//  scaffold.dart, for now, https://github.com/flutter/flutter/issues/51627
class _MBottomSheetSuspendedCurve extends ParametricCurve<double> {
  const _MBottomSheetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  });

  final Curve curve;
  final double startingPoint;

  @override
  String toString() {
    return '${describeIdentity(this)}($startingPoint, $curve)';
  }

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final double curveProgress = (t - startingPoint) / (1 - startingPoint);
    final double transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed)!;
  }
}

class _MDragHandle extends StatelessWidget {
  const _MDragHandle({
    required this.onSemanticsTap,
    required this.handleHover,
    required this.materialState,
    this.dragHandleColor,
    this.dragHandleSize,
  });

  final Color? dragHandleColor;
  final Size? dragHandleSize;
  final ValueChanged<bool> handleHover;
  final Set<MaterialState> materialState;
  final VoidCallback? onSemanticsTap;

  @override
  Widget build(BuildContext context) {
    final BottomSheetThemeData bottomSheetTheme =
        Theme.of(context).bottomSheetTheme;
    final BottomSheetThemeData m3Defaults = _MBottomSheetDefaultsM3(context);
    final Size handleSize = dragHandleSize ??
        bottomSheetTheme.dragHandleSize ??
        m3Defaults.dragHandleSize!;

    return MouseRegion(
      onEnter: (PointerEnterEvent event) => handleHover(true),
      onExit: (PointerExitEvent event) => handleHover(false),
      child: Semantics(
        label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        container: true,
        onTap: onSemanticsTap,
        child: SizedBox(
          height: kMinInteractiveDimension,
          width: kMinInteractiveDimension,
          child: Center(
            child: Container(
              height: handleSize.height,
              width: handleSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(handleSize.height / 2),
                color: MaterialStateProperty.resolveAs<Color?>(
                        dragHandleColor, materialState) ??
                    MaterialStateProperty.resolveAs<Color?>(
                        bottomSheetTheme.dragHandleColor, materialState) ??
                    m3Defaults.dragHandleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalMBottomSheet<T> extends StatefulWidget {
  const _ModalMBottomSheet({
    super.key,
    required this.route,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.isScrollControlled = false,
    this.scrollControlDisabledMaxHeightRatio =
        _defaultScrollControlDisabledMaxHeightRatio,
    this.enableDrag = true,
    this.showDragHandle = false,
  });

  final Color? backgroundColor;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final double? elevation;
  final bool enableDrag;
  final bool isScrollControlled;
  final ModalMBottomSheetRoute<T> route;
  final double scrollControlDisabledMaxHeightRatio;
  final ShapeBorder? shape;
  final bool showDragHandle;

  @override
  _ModalMBottomSheetState<T> createState() => _ModalMBottomSheetState<T>();
}

class ModalMBottomSheetRoute<T> extends PopupRoute<T> {
  ModalMBottomSheetRoute({
    required this.builder,
    this.capturedThemes,
    this.barrierLabel,
    this.barrierOnTapHint,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.showDragHandle,
    required this.isScrollControlled,
    this.scrollControlDisabledMaxHeightRatio =
        _defaultScrollControlDisabledMaxHeightRatio,
    super.settings,
    this.transitionAnimationController,
    this.anchorPoint,
    this.useSafeArea = false,
  });

  final Offset? anchorPoint;
  final Color? backgroundColor;
  final String? barrierOnTapHint;
  final WidgetBuilder builder;
  final CapturedThemes? capturedThemes;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final double? elevation;
  final bool enableDrag;
  final bool isDismissible;
  final bool isScrollControlled;
  final Color? modalBarrierColor;
  final double scrollControlDisabledMaxHeightRatio;
  final ShapeBorder? shape;
  final bool? showDragHandle;
  final AnimationController? transitionAnimationController;
  final bool useSafeArea;

  @override
  final String? barrierLabel;

  final ValueNotifier<EdgeInsets> _clipDetailsNotifier =
      ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  AnimationController? _animationController;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  Widget buildModalBarrier() {
    if (barrierColor.alpha != 0 && !offstage) {
      // changedInternalState is called if barrierColor or offstage updates
      assert(barrierColor != barrierColor.withOpacity(0.0));
      final Animation<Color?> color = animation!.drive(
        ColorTween(
          begin: barrierColor.withOpacity(0.0),
          end:
              barrierColor, // changedInternalState is called if barrierColor updates
        ).chain(CurveTween(
            curve:
                barrierCurve)), // changedInternalState is called if barrierCurve updates
      );
      return AnimatedModalBarrier(
        color: color,
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    } else {
      return ModalBarrier(
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    }
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget content = DisplayFeatureSubScreen(
      anchorPoint: anchorPoint,
      child: Builder(
        builder: (BuildContext context) {
          final BottomSheetThemeData sheetTheme =
              Theme.of(context).bottomSheetTheme;
          final BottomSheetThemeData defaults = Theme.of(context).useMaterial3
              ? _MBottomSheetDefaultsM3(context)
              : const BottomSheetThemeData();
          return _ModalMBottomSheet<T>(
            route: this,
            backgroundColor: backgroundColor ??
                sheetTheme.modalBackgroundColor ??
                sheetTheme.backgroundColor ??
                defaults.backgroundColor,
            elevation: elevation ??
                sheetTheme.modalElevation ??
                sheetTheme.elevation ??
                defaults.modalElevation,
            shape: shape,
            clipBehavior: clipBehavior,
            constraints: constraints,
            isScrollControlled: isScrollControlled,
            scrollControlDisabledMaxHeightRatio:
                scrollControlDisabledMaxHeightRatio,
            enableDrag: enableDrag,
            showDragHandle: showDragHandle ??
                (enableDrag && (sheetTheme.showDragHandle ?? false)),
          );
        },
      ),
    );

    final Widget bottomSheet = useSafeArea
        ? SafeArea(bottom: false, child: content)
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: content,
          );

    return capturedThemes?.wrap(bottomSheet) ?? bottomSheet;
  }

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    if (transitionAnimationController != null) {
      _animationController = transitionAnimationController;
      willDisposeAnimationController = false;
    } else {
      _animationController = BottomSheet.createAnimationController(navigator!);
    }
    return _animationController!;
  }

  @override
  void dispose() {
    _clipDetailsNotifier.dispose();
    super.dispose();
  }

  @override
  Duration get reverseTransitionDuration => _bottomSheetExitDuration;

  @override
  Duration get transitionDuration => _bottomSheetEnterDuration;

  bool _didChangeBarrierSemanticsClip(EdgeInsets newClipDetails) {
    if (_clipDetailsNotifier.value == newClipDetails) {
      return false;
    }
    _clipDetailsNotifier.value = newClipDetails;
    return true;
  }
}

class _ModalMBottomSheetState<T> extends State<_ModalMBottomSheet<T>> {
  ParametricCurve<double> animationCurve = _modalBottomSheetCurve;

  void handleDragEnd(DragEndDetails details, {bool? isClosing}) {
    // Allow the bottom sheet to animate smoothly from its current position.
    animationCurve = _MBottomSheetSuspendedCurve(
      widget.route.animation!.value,
      curve: _modalBottomSheetCurve,
    );
  }

  void handleDragStart(DragStartDetails details) {
    // Allow the bottom sheet to track the user's finger accurately.
    animationCurve = Curves.linear;
  }

  EdgeInsets _getNewClipDetails(Size topLayerSize) {
    return EdgeInsets.fromLTRB(0, 0, 0, topLayerSize.height);
  }

  String _getRouteLabel(MaterialLocalizations localizations) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return localizations.dialogLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String routeLabel = _getRouteLabel(localizations);

    return AnimatedBuilder(
      animation: widget.route.animation!,
      child: BottomSheet(
        animationController: widget.route._animationController,
        onClosing: () {
          if (widget.route.isCurrent) {
            Navigator.pop(context);
          }
        },
        builder: widget.route.builder,
        backgroundColor: widget.backgroundColor,
        elevation: widget.elevation,
        shape: widget.shape,
        clipBehavior: widget.clipBehavior,
        constraints: widget.constraints,
        enableDrag: widget.enableDrag,
        showDragHandle: widget.showDragHandle,
        onDragStart: handleDragStart,
        onDragEnd: handleDragEnd,
      ),
      builder: (BuildContext context, Widget? child) {
        final double animationValue = animationCurve.transform(
          widget.route.animation!.value,
        );
        return Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: routeLabel,
          explicitChildNodes: true,
          child: ClipRect(
            child: _MBottomSheetLayoutWithSizeListener(
              onChildSizeChanged: (Size size) {
                widget.route._didChangeBarrierSemanticsClip(
                  _getNewClipDetails(size),
                );
              },
              animationValue: animationValue,
              isScrollControlled: widget.isScrollControlled,
              scrollControlDisabledMaxHeightRatio:
                  widget.scrollControlDisabledMaxHeightRatio,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _MRenderBottomSheetLayoutWithSizeListener extends RenderShiftedBox {
  _MRenderBottomSheetLayoutWithSizeListener({
    RenderBox? child,
    required _SizeChangeCallback<Size> onChildSizeChanged,
    required double animationValue,
    required bool isScrollControlled,
    required double scrollControlDisabledMaxHeightRatio,
  })  : _onChildSizeChanged = onChildSizeChanged,
        _animationValue = animationValue,
        _isScrollControlled = isScrollControlled,
        _scrollControlDisabledMaxHeightRatio =
            scrollControlDisabledMaxHeightRatio,
        super(child);

  double _animationValue;
  bool _isScrollControlled;
  Size _lastSize = Size.zero;
  _SizeChangeCallback<Size> _onChildSizeChanged;
  double _scrollControlDisabledMaxHeightRatio;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _getSize(constraints);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double height =
        _getSize(BoxConstraints.tightForFinite(width: width)).height;
    if (height.isFinite) {
      return height;
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double width =
        _getSize(BoxConstraints.tightForFinite(height: height)).width;
    if (width.isFinite) {
      return width;
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double height =
        _getSize(BoxConstraints.tightForFinite(width: width)).height;
    if (height.isFinite) {
      return height;
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double width =
        _getSize(BoxConstraints.tightForFinite(height: height)).width;
    if (width.isFinite) {
      return width;
    }
    return 0.0;
  }

  @override
  void performLayout() {
    size = _getSize(constraints);
    if (child != null) {
      final BoxConstraints childConstraints =
          _getConstraintsForChild(constraints);
      assert(childConstraints.debugAssertIsValid(isAppliedConstraint: true));
      child!
          .layout(childConstraints, parentUsesSize: !childConstraints.isTight);
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = _getPositionForChild(size,
          childConstraints.isTight ? childConstraints.smallest : child!.size);
      final Size childSize =
          childConstraints.isTight ? childConstraints.smallest : child!.size;

      if (_lastSize != childSize) {
        _lastSize = childSize;
        _onChildSizeChanged.call(_lastSize);
      }
    }
  }

  double get animationValue => _animationValue;
  bool get isScrollControlled => _isScrollControlled;
  _SizeChangeCallback<Size> get onChildSizeChanged => _onChildSizeChanged;
  double get scrollControlDisabledMaxHeightRatio =>
      _scrollControlDisabledMaxHeightRatio;

  set animationValue(double newValue) {
    if (_animationValue == newValue) {
      return;
    }

    _animationValue = newValue;
    markNeedsLayout();
  }

  set isScrollControlled(bool newValue) {
    if (_isScrollControlled == newValue) {
      return;
    }

    _isScrollControlled = newValue;
    markNeedsLayout();
  }

  set onChildSizeChanged(_SizeChangeCallback<Size> newCallback) {
    if (_onChildSizeChanged == newCallback) {
      return;
    }

    _onChildSizeChanged = newCallback;
    markNeedsLayout();
  }

  set scrollControlDisabledMaxHeightRatio(double newValue) {
    if (_scrollControlDisabledMaxHeightRatio == newValue) {
      return;
    }

    _scrollControlDisabledMaxHeightRatio = newValue;
    markNeedsLayout();
  }

  BoxConstraints _getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      maxHeight: isScrollControlled
          ? constraints.maxHeight
          : constraints.maxHeight * scrollControlDisabledMaxHeightRatio,
    );
  }

  Offset _getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * animationValue);
  }

  Size _getSize(BoxConstraints constraints) {
    return constraints.constrain(constraints.biggest);
  }
}
