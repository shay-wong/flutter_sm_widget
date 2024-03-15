import 'package:example_package/example_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MCircleAvatarExample extends StatelessWidget {
  const MCircleAvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MText('MCircleAvatarExample'),
      ),
      body: const Column(
        children: [
          MCircleAvatar(
            source: '',
            // placeholder: 'assets/images/avatar.png',
          ),
          Expanded(child: ExamplePage()),
        ],
      ),
    );
  }
}
