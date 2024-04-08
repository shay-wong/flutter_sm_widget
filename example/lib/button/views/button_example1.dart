import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MButtonExample1 extends StatelessWidget {
  const MButtonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MButtonExample1'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(),
          MButton(
            onPressed: () {},
            style: MButtonStyle.from(
              // foregroundColor: Colors.amber,
              // useMaterial3: false,
              noOverlay: true,
              noSplash: true,
              overlayColor: Colors.amber,
            ),
            child: const MText('这是一个按钮'),
          ),
          // TextButton(
          //   onPressed: () {},
          //   style: ButtonStyle(
          //     overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          //       if (states.contains(MaterialState.pressed)) {
          //         return null;
          //       }
          //       if (states.contains(MaterialState.hovered)) {
          //         return null;
          //       }
          //       if (states.contains(MaterialState.focused)) {
          //         return null;
          //       }
          //       return null;
          //     }),
          //     splashFactory: NoSplash.splashFactory,
          //   ),
          //   child: const MText('这是一个按钮'),
          // ),
        ],
      ),
    );
  }
}
