import 'package:example/base_list_view.dart';
import 'package:example/text_field/views/simple/custom_toolbar.dart';
import 'package:example/text_field/views/simple/no_keyboard.dart';
import 'package:example/text_field/views/simple/selectable_text.dart';
import 'package:example/text_field/views/simple/widget_span.dart';
import 'package:example/text_field/views/text_field_example.dart';
import 'package:flutter/material.dart';

import 'views/complex/text_demo.dart';
import 'views/text_field_example_01.dart';

class MTextFieldExampleList extends StatelessWidget {
  const MTextFieldExampleList({super.key});

  List<Widget> get itemList => const [
        MTextFieldExample(),
        MTextFieldExample01(),
        CustomToolBar(),
        WidgetSpanDemo(),
        NoSystemKeyboardDemo(),
        SelectableTextDemo(),
        TextDemo(),
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
