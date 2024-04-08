import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MButtonExample extends StatelessWidget {
  const MButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MText('MButtonExample'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceAround,
          runAlignment: WrapAlignment.spaceAround,
          children: [
            _item(
              context,
              MButton(
                onPressed: () {
                  debugPrint('MButton onPressed');
                },
                style: MButtonStyle.from(
                  clearPadding: true,
                  width: 100,
                  height: 50,
                  radius: 20,
                  disabledBackgroundColor: Colors.grey,
                  selectedBackgroundColor: Colors.amber,
                  selectedForegroundColor: Colors.red,
                  foregroundColor: Colors.blue,
                  // clearSplash: true,
                  // clearOverlay: true,
                ),
                isSelected: true,
                child: const MText('这是一个按钮'),
              ),
            ),
            _item(
              context,
              MButton.icon(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
            ),
            for (var i = 0; i < 4; i++)
              _item(
                context,
                MButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.face),
                  label: const MText('笑脸'),
                  alignment: MButtonIconAlignment.values[i],
                ),
              ),
            _item(
              context,
              MButton.text(
                data: '这是一个按钮',
                onPressed: () {},
              ),
            ),
            _item(
              context,
              MIconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
                style: MButtonStyle.from(
                  clearPadding: true,
                  // clearOverlay: true,
                  // clearSplash: true,
                  padding: const EdgeInsets.all(20),
                ),
                clearPadding: true,
                // clearOverlay: true,
                clearSplash: true,
                padding: const EdgeInsets.all(20),
              ),
            ),
            _item(
              context,
              IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                  // overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                padding: const EdgeInsets.all(20),
              ),
            ),
            _item(
              context,
              MElevatedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
            ),
            _item(
              context,
              MFilledButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
            ),
            _item(
              context,
              MOutlinedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
            ),
            const Row(),
            MIconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.face,
              ),
              iconSize: 50,
              padding: EdgeInsets.zero,
              style: IconButton.styleFrom(
                // clearPadding: true,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                backgroundColor: Colors.amber,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.face,
              ),
              iconSize: 50,
              padding: EdgeInsets.zero,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                backgroundColor: Colors.amber,
              ),
            ),
            MIconButton(
              onPressed: () {},
              icon: const MImage(
                'assets/images/avatar.png',
                fit: BoxFit.fill,
                size: 50,
              ),
              iconSize: 50,
              clearPadding: true,
              style: MButtonStyle.from(
                // clearOverlay: true,
                backgroundColor: Colors.amber,
                overlayHighlightColor: Colors.blue,
              ),
              padding: const EdgeInsets.all(10),
            ),
            IconButton(
              onPressed: () {},
              icon: const MImage(
                'assets/images/avatar.png',
                fit: BoxFit.fill,
                size: 50,
              ),
              iconSize: 50,
              padding: EdgeInsets.zero,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                backgroundColor: Colors.amber,
                highlightColor: Colors.blue,
                splashFactory: NoSplash.splashFactory,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.blue,
            ),
            for (int i = 0; i < 4; i++)
              MButton.icon(
                onPressed: i.isEven ? null : () {},
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF46D7B7),
                  size: 12,
                ),
                label: const MText(
                  '杭州',
                  color: Color(0xFF353C47),
                  fontSize: 12,
                  fontWeight: MFontWeight.semiBold,
                  forceStrutHeight: true,
                ),
                style: MButtonStyle.from(
                  backgroundColor: const Color(0xFFDBFFF5),
                  clearPadding: true,
                  minimumSize: const Size(50, 22),
                  maximumSize: const Size.fromHeight(22),
                  padding: const EdgeInsets.only(left: 5, right: 10),
                ),
                space: 2,
              ),
            MButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF46D7B7),
                size: 12,
              ),
              label: const MText(
                '杭州',
                fontSize: 12,
                fontWeight: MFontWeight.semiBold,
                // forceStrutHeight: true,
              ),
              style: MButtonStyle.from(
                backgroundColor: const Color(0xFFDBFFF5),
                clearPadding: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              space: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF46D7B7),
                size: 12,
              ),
              label: const MText(
                '杭州',
                fontSize: 12,
                fontWeight: MFontWeight.semiBold,
                forceStrutHeight: true,
              ),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFDBFFF5),
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    Widget item, {
    String? title,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        item,
        MText(
          title ?? item.runtimeType.toString(),
          fontSize: 15,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
