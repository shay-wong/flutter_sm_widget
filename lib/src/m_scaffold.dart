import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'm_app_bar.dart';

class MScaffold extends Scaffold {
  MScaffold({
    super.key,
    PreferredSizeWidget? appBar,
    super.body,
    String? title,
    Color? titleColor,
    Widget? leading,
    bool isRoot = false,
    List<Widget>? actions,
    VoidCallback? onBack,
    String? previousRoute,
    Color? barBackgourndColor,
    Color? barForegroundColor,
    bool? centerTitle,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    super.drawerDragStartBehavior = DragStartBehavior.start,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.endDrawerEnableOpenDragGesture = true,
    super.restorationId,
  }) : super(
          appBar: appBar ??
              (title != null || actions != null
                  ? MAppBar(
                      titleText: title,
                      leading: leading,
                      isRoot: isRoot,
                      actions: actions,
                      onBack: onBack,
                      backgroundColor: barBackgourndColor,
                      foregroundColor: barForegroundColor,
                      previousRoute: previousRoute,
                      centerTitle: centerTitle ?? true,
                    )
                  : null),
        );
}
