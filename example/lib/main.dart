import 'package:example/button_example.dart';
import 'package:example/circle_avatar_example.dart';
import 'package:example/container_example.dart';
import 'package:example/text_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List get itemList => [
        const MContainerExample(),
        const MTextExample(),
        const MCircleAvatarExample(),
        const MButtonExample(),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMWidget Example'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(itemList[index].runtimeType.toString()),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => itemList[index],
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              height: 0.5,
              indent: 15,
              endIndent: 15,
            );
          },
          itemCount: itemList.length,
        ),
      ),
    );
  }
}
