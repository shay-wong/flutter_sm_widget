import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';
import 'package:get/get.dart';

class MCupertinoDialogExample extends StatelessWidget {
  const MCupertinoDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      title: 'MCupertinoDialogExample',
      body: Center(
        child: Column(
          children: [
            MButton(
              child: const MText('MCupertinoActionSheet'),
              onPressed: () {
                Get.bottomSheet(
                  elevation: 0,
                  backgroundColor: const Color(0xFFF6F6F6),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  const MCupertinoActionSheet(
                    actionsText: ['查看资料', '举报'],
                    hasCancelButton: true,
                    cancelPadding: EdgeInsets.only(top: 5),
                    radius: 0,
                    cancelRadius: 0,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    padding: EdgeInsets.zero,
                    actionsColor: Colors.white,
                    dividerColor: Color(0xFFE5E5E5),
                  ),
                );
              },
            ),
            MButton(
              child: const MText('showModalBottomSheet'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return MContainer(
                      size: 200,
                      color: Colors.red,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
