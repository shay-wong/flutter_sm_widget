import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../text/my_special_text_span_builder.dart';
import '../text/selection_area.dart';

class JoinZeroWidthSpaceExample extends StatefulWidget {
  const JoinZeroWidthSpaceExample({super.key});

  @override
  State<JoinZeroWidthSpaceExample> createState() =>
      _JoinZeroWidthSpaceExampleState();
}

class _JoinZeroWidthSpaceExampleState extends State<JoinZeroWidthSpaceExample> {
  final MySpecialTextSpanBuilder builder = MySpecialTextSpanBuilder();

  final String content =
      'relate to \$issue 26748\$ .[love]Extended text help you to build rich text quickly. any special text you will have with extended text. '
      'It\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[love]'
      '1234567 if you meet any problem, please let me know @zmtzawqlp .';

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

  Widget _buildText({
    int? maxLines = 4,
    String? title,
    bool joinZeroWidthSpace = false,
  }) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? 'joinZeroWidthSpace: $joinZeroWidthSpace',
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
                joinZeroWidthSpace: joinZeroWidthSpace,
                child: MText(
                  content,
                  onSpecialTextTap: onSpecialTextTap,
                  specialTextSpanBuilder: builder,
                  joinZeroWidthSpace: joinZeroWidthSpace,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Zero-Width Space'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildText(
                joinZeroWidthSpace: false,
              ),
              _buildText(
                joinZeroWidthSpace: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
