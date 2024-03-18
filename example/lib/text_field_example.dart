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
              contentPadding: EdgeInsets.all(10),
              fillColor: Colors.amber,
              width: 200,
              radius: 25,
              forceStrutHeight: true,
              side: BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderStyle: MTextFieldBorderStyle.outline,
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
                size: 80,
              ),
              suffixIconConstraints: BoxConstraints(maxHeight: 50),
            ),
            SizedBox(
              height: 100,
            ),
            TextField(
              // style: TextStyle(fontSize: 80),
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.zero,
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
          ],
        ),
      ),
    );
  }
}
