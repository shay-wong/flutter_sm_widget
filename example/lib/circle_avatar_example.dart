import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

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
            placeholder: 'assets/images/avatar.png',
            diameter: 100,
            backgroundColor: Colors.amber,
          ),
          MCircleAvatar(
            source: '',
            diameter: 100,
            backgroundColor: Colors.amber,
          ),
          MCircleAvatar(
            source: '123',
            placeholder: 'assets/images/avatar.png',
            diameter: 100,
            backgroundColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
