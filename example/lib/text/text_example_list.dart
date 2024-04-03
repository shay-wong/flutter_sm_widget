import 'package:example/base_list_view.dart';
import 'package:example/text/views/text_background_example.dart';
import 'package:flutter/material.dart';

import 'views/join_zero_width_space_example.dart';
import 'views/regexp_text_example.dart';
import 'views/text_custom_overflow_example.dart';
import 'views/text_example.dart';
import 'views/text_selection_area_example.dart';
import 'views/text_special_example.dart';

class MTextExampleList extends StatelessWidget {
  const MTextExampleList({super.key});
  List<Widget> get itemList => [
        const MTextExample(),
        const TextBackgroundExample(),
        const TextCustomOverflowExample(),
        const JoinZeroWidthSpaceExample(),
        const RegExpTextExample(),
        const TextSelectionAreaExample(),
        const TextSpecialExample(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MText Example List'),
      ),
      body: BaseListView(itemList: itemList),
    );
  }
}
