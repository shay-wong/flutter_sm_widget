import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MButtonExample extends StatelessWidget {
  const MButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MButton(
            onPressed: () {},
            clearPadding: true,
            width: 100,
            height: 50,
            radius: 10,
            // noSplash: true,
            // noHighlight: true,
            child: const MText('12311111111'),
          ),
        ],
      ),
    );
  }
}
