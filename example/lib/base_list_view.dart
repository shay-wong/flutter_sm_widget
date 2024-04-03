import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_widget/sm_widget.dart';

class BaseListView extends StatelessWidget {
  const BaseListView({
    super.key,
    required this.itemList,
  });

  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return MListTile(
          title: MText(itemList[index].runtimeType.toString()),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.grey,
          ),
          onTap: () {
            navigator?.push(
              GetPageRoute(
                page: () => itemList[index],
                routeName: itemList[index].runtimeType.toString(),
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
    );
  }
}
