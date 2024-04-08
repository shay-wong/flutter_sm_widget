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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MButton(
                onPressed: () {},
                style: MButtonStyle.from(
                  clearPadding: true,
                  width: 100,
                  height: 50,
                  radius: 20,
                  noSplash: true,
                  noOverlay: true,
                ),
                child: const MText('这是一个按钮'),
              ),
              MButton.icon(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
              MIconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < 4; i++)
                MButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.face),
                  label: const MText('笑脸'),
                  alignment: MButtonIconAlignment.values[i],
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                style: MButtonStyle.from(
                  clearPadding: true,
                  // noSplash: true,
                  noOverlay: true,
                  backgroundColor: Colors.amber,
                  overlayHighlightColor: Colors.blue,
                ),
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
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: [
              for (int i = 0; i < 4; i++)
                MButton.icon(
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
            ],
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MElevatedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
              MFilledButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
              MOutlinedButton(
                onPressed: () {},
                child: const MText(
                  '这是一个按钮',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
