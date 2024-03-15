import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MListTileExample extends StatelessWidget {
  const MListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MListTileExample'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ListView.separated(
              itemBuilder: (context, index) => MListTile(
                trailing: const MImage(
                  'assets/images/avatar.png',
                  size: 80,
                  fit: BoxFit.fill,
                ),
                title: const MText(
                  '这是一个列表',
                ),
                height: 80,
                detailText: '这是一个详情',
                showArrow: true,
                trailingOverride: false,
                onTap: () {},
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                );
              },
              itemCount: 10,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: const MText(
                  '这是一个列表',
                ),
                trailing: const MText(
                  '这是一个详情',
                ),
                onTap: () {},
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
