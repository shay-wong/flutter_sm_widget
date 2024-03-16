import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MButtonExample extends StatelessWidget {
  const MButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MText('MButtonExample'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MButton(
                onPressed: () {},
                clearPadding: true,
                width: 100,
                height: 50,
                radius: 10,
                // noSplash: true,
                // noHighlight: true,
                child: const MText('这是一个按钮'),
              ),
              MButton.icon(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
              MIconButton(
                onPressed: () {},
                icon: const Icon(Icons.face),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < 4; i++)
                MButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.face),
                  label: const MText('笑脸'),
                  alignment: MButtonIconAlignment.values[i],
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MElevatedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
              MFilledButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
              MOutlinedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
