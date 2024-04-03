import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MTextExample extends StatelessWidget {
  const MTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MText Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              const Text(
                'Text',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
                textScaler: TextScaler.noScaling,
              ),
              const Spacer(),
              const MText(
                'MText',
                color: Colors.amber,
                fontSize: 20,
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  text: 'RichText',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Text(
            'Hello World!!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const MText(
            'Hello World!!',
            color: Colors.amber,
            isBold: true,
            fontSize: 30,
          ),
          const MText.rich(
            color: Colors.red,
            isBold: true,
            fontSize: 20,
            children: [
              MTextSpan(text: 'Hello World,'),
              MTextSpan(
                text: 'I am RichText',
                color: Colors.blue,
                fontSize: 30,
              ),
            ],
          ),
          const Text.rich(
            TextSpan(
              children: [
                MTextSpan(text: 'Hello World,'),
                MTextSpan(
                  text: 'I am RichText',
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ],
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textScaler: TextScaler.noScaling,
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              children: [
                MTextSpan(text: 'Hello World,'),
                TextSpan(
                  text: 'I am RichText',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          MRichText.children(
            children: const [
              MTextSpan(text: 'Hello World,'),
              MTextSpan(
                text: 'I am RichText',
                color: Colors.blue,
                fontSize: 30,
              ),
            ],
            color: Colors.red,
            isBold: true,
            fontSize: 20,
          ),
          const Text(
            'Hello World!!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textScaler: TextScaler.noScaling,
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Hello World!!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
