import 'package:example/base_list_view.dart';
import 'package:example/text_field/views/text_field_example.dart';
import 'package:flutter/material.dart';

class MTextFieldExampleList extends StatelessWidget {
  const MTextFieldExampleList({super.key});

  List<Widget> get itemList => const [
        MTextFieldExample(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTextField Example List'),
      ),
      body: BaseListView(itemList: itemList),
    );
  }
}
