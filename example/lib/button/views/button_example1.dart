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
              clearPadding: true,
              width: 100,
              height: 50,
              radius: 20,
              disabledBackgroundColor: Colors.grey,
              selectedBackgroundColor: Colors.amber,
              selectedForegroundColor: Colors.red,
              // foregroundColor: Colors.blue,
              // clearSplash: true,
              // clearOverlay: true,
            ),
            isSelected: true,
            child: const MText('这是一个按钮'),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: MButtonStyle.from(
              clearPadding: true,
              width: 100,
              height: 50,
              radius: 20,
              disabledBackgroundColor: Colors.grey,
              selectedBackgroundColor: Colors.amber,
              selectedForegroundColor: Colors.red,
              // foregroundColor: Colors.blue,
              // clearSplash: true,
              // clearOverlay: true,
            ),
            statesController: MaterialStatesController(
              <MaterialState>{
                MaterialState.selected,
              },
            ),
            child: const MText('这是一个按钮'),
          ),
        ],
      ),
    );
  }
}
