import 'package:flutter/material.dart';

import '../base_list_view.dart';
import 'views/button_example.dart';
import 'views/button_example1.dart';

class MButtonExampleList extends StatelessWidget {
  const MButtonExampleList({super.key});
  List<Widget> get itemList => [
        const MButtonExample(),
        const MButtonExample1(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MButton Example List'),
      ),
      body: BaseListView(itemList: itemList),
    );
  }
}
