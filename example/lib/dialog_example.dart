import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';
import 'package:get/get.dart';

class MDialogExample extends StatelessWidget {
  const MDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MText('MDialogExample'),
      ),
      body: Center(
        child: Column(
          children: [
            MButton(
              child: const MText('Show MDialog-0'),
              onPressed: () {
                MDialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const MText('This is a typical dialog.'),
                        const SizedBox(height: 15),
                        MButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const MText('Close'),
                        ),
                      ],
                    ),
                  ),
                ).show();
              },
            ),
            MButton(
              child: const MText('Show Fullscreen MDialog-1'),
              onPressed: () {
                MDialog.fullscreen(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const MText('This is a fullscreen dialog.'),
                      const SizedBox(height: 15),
                      MButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const MText('Close'),
                      ),
                    ],
                  ),
                ).show();
              },
            ),
            MButton(
              child: const MText('Show MAlertDialog-0'),
              onPressed: () => MAlertDialog(
                title: const MText('AlertDialog Title'),
                content: const MText('AlertDialog description'),
                actions: <Widget>[
                  MButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const MText('Cancel'),
                  ),
                  MButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const MText('OK'),
                  ),
                ],
              ).show(),
            ),
            MButton(
              child: const MText('Show MAlertDialog-1'),
              onPressed: () => MAlertDialog(
                title: const MText('Basic dialog title'),
                content: const MText(
                  'A dialog is a type of modal window that\n'
                  'appears in front of app content to\n'
                  'provide critical information, or prompt\n'
                  'for a decision to be made.',
                ),
                actions: <Widget>[
                  MButton(
                    style: MButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const MText('Disable'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  MButton(
                    style: MButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const MText('Enable'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ).show(),
            ),
            MButton(
              child: const MText('show MAlertDialog-3'),
              onPressed: () {
                navigator?.restorablePush(_dialogBuilder);
              },
            ),
            MButton(
              child: const MText('show MAlertDialog.adaptive-4'),
              onPressed: () {
                MAlertDialog.adaptive(
                  title: const MText('AlertDialog Title'),
                  content: const MText('AlertDialog description'),
                  actions: <Widget>[
                    adaptiveAction(
                      context: context,
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const MText('Cancel'),
                    ),
                    adaptiveAction(
                      context: context,
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const MText('OK'),
                    ),
                  ],
                ).show();
              },
            ),
          ],
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const MText('Basic dialog title'),
          content: const MText(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            MButton(
              style: MButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MText('Disable'),
              onPressed: () {
                Get.back();
              },
            ),
            MButton(
              style: MButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MText('Enable'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return MButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
