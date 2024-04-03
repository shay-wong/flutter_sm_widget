import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

import '../../special_text/my_special_text_span_builder.dart';

class SelectableTextDemo extends StatelessWidget {
  const SelectableTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectableText'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: MSelectableText(
          '[17]Extended text help you to build rich text quickly. any special text you will have with extended text. '
          '\n\nIt\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[17]'
          '\n\nif you meet any problem, please let me know @zmtzawqlp .[36]',
          specialTextSpanBuilder: MySpecialTextSpanBuilder(),
        ),
      ),
    );
  }
}
