// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../text/my_special_text_span_builder.dart';
import '../text/selection_area.dart';

class TextCustomOverflowExample extends StatefulWidget {
  const TextCustomOverflowExample({super.key});

  @override
  State<TextCustomOverflowExample> createState() => _TextCustomOverflowExampleState();
}

class _TextCustomOverflowExampleState extends State<TextCustomOverflowExample> {
  final String content = ''
      'relate to \$issue 26748\$ .[love]Extended text help you to build rich text quickly. any special text you will have with extended text. '
      'It\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[love]'
      '1234567 if you meet any problem, please let me know @zmtzawqlp .';
  final MySpecialTextSpanBuilder builder = MySpecialTextSpanBuilder();
  bool _joinZeroWidthSpace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('custom text over flow'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.style),
              onPressed: () {
                setState(() {
                  _joinZeroWidthSpace = !_joinZeroWidthSpace;
                });
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildText(maxLines: null, title: 'Full Text'),
              _buildText(position: TextOverflowPosition.end),
              _buildText(position: TextOverflowPosition.start),
              _buildText(position: TextOverflowPosition.middle),
              _buildText(position: TextOverflowPosition.middle, maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    TextOverflowPosition position = TextOverflowPosition.end,
    int? maxLines = 4,
    String? title,
  }) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title ??
                    'position: ${position.toString().replaceAll('TextOverflowPosition.', '')}${maxLines != null ? ' , maxLines: $maxLines' : ''}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              CommonSelectionArea(
                // if betterLineBreakingAndOverflowStyle is true, you must take care of copy text.
                // override [TextSelectionControls.handleCopy], remove zero width space.
                joinZeroWidthSpace: _joinZeroWidthSpace,
                child: MText(
                  content,
                  onSpecialTextTap: onSpecialTextTap,
                  specialTextSpanBuilder: builder,
                  joinZeroWidthSpace: _joinZeroWidthSpace,
                  overflowWidget: TextOverflowWidget(
                    position: position,
                    align: TextOverflowAlign.center,
                    // just for debug
                    debugOverflowRectColor: Colors.red.withOpacity(0.1),
                    child: Container(
                      //color: Colors.yellow,
                      child: SelectionContainer.disabled(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('\u2026 '),
                            InkWell(
                              child: const Text(
                                'more',
                              ),
                              onTap: () {
                                launchUrl(Uri.parse('https://github.com/fluttercandies/extended_text'));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  maxLines: maxLines,
                ),
              ),
            ],
          )),
    );
  }

  void onSpecialTextTap(dynamic parameter) {
    if (parameter.toString().startsWith('\$')) {
      if (parameter.toString().contains('issue')) {
        launchUrl(Uri.parse('https://github.com/flutter/flutter/issues/26748'));
      } else {
        launchUrl(Uri.parse('https://github.com/fluttercandies'));
      }
    } else if (parameter.toString().startsWith('@')) {
      launchUrl(Uri.parse('mailto:zmtzawqlp@live.com'));
    }
  }
}
