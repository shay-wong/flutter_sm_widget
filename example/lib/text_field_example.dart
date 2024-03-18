import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MTextFieldExample extends StatelessWidget {
  const MTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      title: 'MTextFieldExample',
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            MTextField(
              hintText: '请输入内容',
              contentPadding: EdgeInsets.symmetric(horizontal: 30),
              fillColor: Colors.white,
              width: 300,
              radius: 25,
              forceStrutHeight: true,
              // side: BorderSide(
              //   width: 1,
              //   color: Colors.red,
              // ),
              borderStyle: MTextFieldBorderStyle.underline,
              label: MText.rich(
                text: MTextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Text(
                        'Username',
                      ),
                    ),
                    WidgetSpan(
                      child: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              suffix: MText('123'),
              suffixPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              suffixIcon: Icon(
                Icons.face,
                size: 30,
              ),
              suffixIconPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              suffixIconConstraints: BoxConstraints(maxHeight: 30),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // style: TextStyle(fontSize: 80),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                label: MText.rich(
                  text: MTextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          'Username',
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                suffixIcon: Icon(
                  Icons.face,
                  size: 30,
                ),
                suffixIconConstraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                constraints: BoxConstraints(
                  maxWidth: 200,
                  maxHeight: 50,
                ),
                fillColor: Colors.amber,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gapPadding: 10,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gapPadding: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gapPadding: 10000,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gapPadding: 0,
                ),
              ),
            ),

            TextField(
              // style: TextStyle(fontSize: 80),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                label: MText.rich(
                  text: MTextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          'Username',
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                suffixIcon: Icon(
                  Icons.face,
                  size: 30,
                ),
                suffixIconConstraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                constraints: BoxConstraints(
                  maxWidth: 200,
                  maxHeight: 50,
                ),
                fillColor: Colors.white,
                filled: true,
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20),
                MIconButton(
                  icon: MImage(
                    'assets/images/avatar1.png',
                    package: 'example_package',
                    width: 22,
                    height: 28,
                  ),
                ),
                MTextField(
                  width: 300,
                  hintText: '请输入消息...',
                  hintColor: Color(0xFFD0D0D0),
                  fontSize: 14,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  suffixIcon: Icon(Icons.face),
                  suffixIconConstraints: BoxConstraints(
                    maxWidth: 23,
                    maxHeight: 23,
                  ),
                  border: InputBorder.none,
                  radius: 25,
                  // borderStyle: MTextFieldBorderStyle.outline,
                  maxLines: 4,
                  minLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
