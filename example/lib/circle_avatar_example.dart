import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MCircleAvatarExample extends StatelessWidget {
  const MCircleAvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MCircleAvatar(
            '',
            // placeholder: 'assets/images/avatar.png',
          ),
        ],
      ),
    );
  }
}
