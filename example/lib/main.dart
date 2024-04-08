import 'package:example/base_list_view.dart';
import 'package:example/cupertino_dialog_example.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_widget/sm_widget.dart';

import 'button/button_example_list.dart';
import 'circle_avatar_example.dart';
import 'container_example.dart';
import 'dialog_example.dart';
import 'expandable_example.dart';
import 'list_tile_example.dart';
import 'text/text_example_list.dart';
import 'text_field/text_field_example_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Widget> get itemList => [
        const MContainerExample(),
        const MTextExampleList(),
        const MButtonExampleList(),
        const MCircleAvatarExample(),
        const MDialogExample(),
        const MCupertinoDialogExample(),
        const MListTileExample(),
        const ExpandableExample(),
        const MTextFieldExampleList(),
      ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        // useMaterial3: false,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const MText('SMWidget Example'),
        ),
        body: BaseListView(
          itemList: itemList,
        ),
      ),
    );
  }
}
