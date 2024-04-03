import 'package:example/text/text/regexp_special_text_span_builder.dart';
import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RegExpTextExample extends StatelessWidget {
  const RegExpTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quickly build special text'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: MText(
          '[love]Extended text help you to build rich text quickly. any special text you will have with extended text. '
          '\n\nIt\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[love]'
          '\n\nif you meet any problem, please let me know @zmtzawqlp and send an mailto:zmtzawqlp@live.com to me .[sun_glasses] ',
          onSpecialTextTap: (dynamic parameter) {
            if (parameter.toString().startsWith('\$')) {
              launchUrl(Uri.parse('https://github.com/fluttercandies'));
            } else if (parameter.toString().startsWith('@')) {
              launchUrl(Uri.parse('mailto:zmtzawqlp@live.com'));
            } else if (parameter.toString().startsWith('mailto:')) {
              launchUrl(Uri.parse(parameter.toString()));
            }
          },
          specialTextSpanBuilder: MyRegExpSpecialTextSpanBuilder(),
          overflow: TextOverflow.ellipsis,
          //style: TextStyle(background: Paint()..color = Colors.red),
          maxLines: 10,
        ),
      ),
    );
  }
}
