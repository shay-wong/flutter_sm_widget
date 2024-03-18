import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'm_text.dart';
import 'sm_button/sm_button.dart';

class MAppBar extends AppBar {
  MAppBar({
    super.key,
    Widget? leading,
    super.automaticallyImplyLeading = true,
    Widget? title,
    String? titleText,
    Color? color,
    double? fontSize,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.centerTitle,
    super.backgroundColor,
    super.foregroundColor,
    super.elevation,
    super.toolbarHeight,
    VoidCallback? onBack,
    String? previousRoute,
    bool isRoot = false,
    String? rootName,
    super.surfaceTintColor,
    super.shadowColor,
    IconData? backIconData,
    double? backIconSize,
    super.scrolledUnderElevation,
    super.notificationPredicate = defaultScrollNotificationPredicate,
    super.shape,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency = false,
    super.clipBehavior,
  }) : super(
          title: titleText == null
              ? title
              : MText(
                  titleText,
                  style: Get.theme.appBarTheme.titleTextStyle?.copyWith(
                    fontSize: fontSize,
                    color: color ?? foregroundColor,
                  ),
                ),
          leading: leading ??
              (isRoot
                  ? null
                  // TODO: 为什么放 AppBar 上和 IconButton 的点击大小会不一样?
                  : MIconButton(
                      onPressed: onBack ?? () => Get.back(),
                      icon: Icon(
                        backIconData ?? Icons.arrow_back_ios_new_rounded,
                        size: backIconSize ?? 18,
                        color: foregroundColor,
                      ),
                    )),
        );
}
