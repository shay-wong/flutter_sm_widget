// ignore_for_file: avoid_unnecessary_containers

import 'package:example/text/text/my_special_text_span_builder.dart';
import 'package:example/text/text/selection_area.dart';
import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TextSelectionAreaExample extends StatelessWidget {
  const TextSelectionAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    const String content =
        '[love]Extended text help you to build rich text quickly. any special text you will have with extended text. '
        'It\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[love]'
        'if you meet any problem, please let me know @zmtzawqlp .[sun_glasses]';
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectionArea Support'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20.0),
          child: CommonSelectionArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  content,
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                MText(
                  content,
                  onSpecialTextTap: (dynamic parameter) {
                    if (parameter.toString().startsWith('\$')) {
                      launchUrl(Uri.parse('https://github.com/fluttercandies'));
                    } else if (parameter.toString().startsWith('@')) {
                      launchUrl(Uri.parse('mailto:zmtzawqlp@live.com'));
                    }
                  },
                  specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                  overflow: TextOverflow.ellipsis,
                  overflowWidget: TextOverflowWidget(
                    position: TextOverflowPosition.middle,
                    align: TextOverflowAlign.center,
                    // just for debug
                    debugOverflowRectColor: Colors.red.withOpacity(0.1),
                    child: Container(
                      //color: Colors.yellow,
                      child:
                          // overwidget text should be not selectable
                          SelectionContainer.disabled(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('\u2026 '),
                            InkWell(
                              child: const Text(
                                'more',
                              ),
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://github.com/fluttercandies/extended_text'));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
