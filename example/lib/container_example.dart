import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MContainerExample extends StatelessWidget {
  const MContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MContainer Example'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MContainer(
            color: Colors.blue,
          ),
          MContainer(
            minWidth: 25,
            minHeight: 25,
            maxWidth: 200,
            maxHeight: 200,
            color: Colors.green,
          ),
          MContainer(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          MContainer(
            width: 50,
            height: 50,
            minWidth: 25,
            minHeight: 25,
            maxWidth: 40,
            maxHeight: 40,
            color: Colors.blue,
          ),
          MContainer(
            width: 40,
            height: 40,
            color: Colors.yellow,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: MContainer(
              width: 200,
              height: 200,
              color: Colors.purple,
              shape: MBoxShape.circle,
              child: MContainer(
                width: 100,
                height: 100,
                color: Colors.orange,
                radius: 20,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 210,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
