import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';
import 'package:get/get.dart';

import 'button_example.dart';
import 'circle_avatar_example.dart';
import 'container_example.dart';
import 'dialog_example.dart';
import 'expandable_example.dart';
import 'list_tile_example.dart';
import 'text_example.dart';
import 'text_field_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Widget> get itemList => [
        const MContainerExample(),
        const MTextExample(),
        const MButtonExample(),
        const MCircleAvatarExample(),
        const MDialogExample(),
        const MListTileExample(),
        const ExpandableExample(),
        const MTextFieldExample(),
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
          title: const Text('SMWidget Example'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: MText(itemList[index].runtimeType.toString()),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
              onTap: () {
                Get.to(() => itemList[index]);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              height: 0.5,
              indent: 15,
              endIndent: 15,
            );
          },
          itemCount: itemList.length,
        ),
      ),
    );
  }
}
