import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MTextFieldExample extends StatelessWidget {
  const MTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      title: 'MTextFieldExample',
      // bottomSheet: MContainer(
      //   height: 100,
      //   color: Colors.red,
      // ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            // const MTextField(
            //   hintText: '请输入内容',
            //   contentPadding: EdgeInsets.symmetric(horizontal: 30),
            //   fillColor: Colors.white,
            //   width: 300,
            //   radius: 25,
            //   forceStrutHeight: true,
            //   // side: BorderSide(
            //   //   width: 1,
            //   //   color: Colors.red,
            //   // ),
            //   borderStyle: MTextFieldBorderStyle.underline,
            //   label: MText.rich(
            //     text: MTextSpan(
            //       children: <InlineSpan>[
            //         WidgetSpan(
            //           child: Text(
            //             'Username',
            //           ),
            //         ),
            //         WidgetSpan(
            //           child: Text(
            //             '*',
            //             style: TextStyle(color: Colors.red),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   suffix: MText('123'),
            //   suffixPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            //   suffixIcon: Icon(
            //     Icons.face,
            //     size: 30,
            //   ),
            //   suffixIconPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            //   suffixIconConstraints: BoxConstraints(maxHeight: 30),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const TextField(
            //   // style: TextStyle(fontSize: 80),
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.all(20),
            //     label: MText.rich(
            //       text: MTextSpan(
            //         children: <InlineSpan>[
            //           WidgetSpan(
            //             child: Text(
            //               'Username',
            //             ),
            //           ),
            //           WidgetSpan(
            //             child: Text(
            //               '*',
            //               style: TextStyle(color: Colors.red),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     suffixIcon: Icon(
            //       Icons.face,
            //       size: 30,
            //     ),
            //     suffixIconConstraints: BoxConstraints(maxHeight: 40, minWidth: 40),
            //     constraints: BoxConstraints(
            //       maxWidth: 200,
            //       maxHeight: 50,
            //     ),
            //     fillColor: Colors.amber,
            //     filled: true,
            //     disabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       gapPadding: 10,
            //     ),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       gapPadding: 10,
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       gapPadding: 10000,
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       gapPadding: 0,
            //     ),
            //   ),
            // ),
            // const TextField(
            //   // style: TextStyle(fontSize: 80),
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.all(20),
            //     label: MText.rich(
            //       text: MTextSpan(
            //         children: <InlineSpan>[
            //           WidgetSpan(
            //             child: Text(
            //               'Username',
            //             ),
            //           ),
            //           WidgetSpan(
            //             child: Text(
            //               '*',
            //               style: TextStyle(color: Colors.red),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     suffixIcon: Icon(
            //       Icons.face,
            //       size: 30,
            //     ),
            //     suffixIconConstraints: BoxConstraints(maxHeight: 40, minWidth: 40),
            //     constraints: BoxConstraints(
            //       maxWidth: 200,
            //       maxHeight: 50,
            //     ),
            //     fillColor: Colors.white,
            //     filled: true,
            //     disabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //     ),
            //     border: UnderlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     const SizedBox(width: 20),
            //     const MIconButton(
            //       icon: MImage(
            //         'assets/images/avatar1.png',
            //         package: 'example_package',
            //         width: 22,
            //         height: 28,
            //       ),
            //     ),
            //     MTextField(
            //       width: 300,
            //       hintText: '请输入消息...',
            //       hintColor: const Color(0xFFD0D0D0),
            //       fontSize: 14,
            //       fillColor: Colors.white,
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //       suffix: MIconButton(
            //         onPressed: () {
            //           showModalBottomSheet(
            //             context: context,
            //             builder: (context) {
            //               return MContainer(
            //                 size: 200,
            //                 color: Colors.red,
            //               );
            //             },
            //           );
            //         },
            //         icon: const MImage(
            //           'assets/images/avatar1.png',
            //           package: 'example_package',
            //           width: 22,
            //           height: 28,
            //         ),
            //       ),
            //       suffixIconConstraints: const BoxConstraints(
            //         maxHeight: 23,
            //       ),
            //       border: InputBorder.none,
            //       radius: 25,
            //       // borderStyle: MTextFieldBorderStyle.outline,
            //       maxLines: 4,
            //       minLines: 1,
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     const SizedBox(width: 20),
            //     const MIconButton(
            //       icon: MImage(
            //         'assets/images/avatar1.png',
            //         package: 'example_package',
            //         width: 22,
            //         height: 28,
            //       ),
            //     ),
            //     TextField(
            //       style: const TextStyle(fontSize: 14),
            //       decoration: InputDecoration(
            //         constraints: const BoxConstraints(maxWidth: 300),
            //         hintText: '请输入消息...',
            //         hintStyle: const TextStyle(
            //           color: Color(0xFFD0D0D0),
            //         ),
            //         fillColor: Colors.white,
            //         filled: true,
            //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //         suffix: MIconButton(
            //           onPressed: () {},
            //           icon: const MImage(
            //             'assets/images/avatar1.png',
            //             package: 'example_package',
            //           ),
            //           style:
            //               IconButton.styleFrom(maximumSize: const Size.square(39), minimumSize: const Size.square(20)),
            //           // maximumSize: const Size.square(23),
            //         ),
            //         border: InputBorder.none,
            //       ),
            //       maxLines: 4,
            //       minLines: 1,
            //     ),
            //   ],
            // ),
            Row(
              children: [
                const SizedBox(width: 10),
                const MIconButton(
                  icon: MImage(
                    'assets/images/avatar1.png',
                    package: 'example_package',
                    width: 22,
                    height: 28,
                  ),
                ),
                Expanded(
                  child: MTextField(
                    // controller: controller.textController,
                    color: Colors.amber,
                    hintText: '请输入消息...',
                    hintColor: const Color(0xFFD0D0D0),
                    fontSize: 14,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MIconButton(
                          clearPadding: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8.5),
                          icon: MImage(
                            'assets/images/avatar1.png',
                            package: 'example_package',
                            size: 23,
                          ),
                          noSplash: true,
                          noHighlight: true,
                        ),
                        MIconButton(
                          onPressed: () async {},
                          icon: const MImage(
                            'assets/images/avatar1.png',
                            package: 'example_package',
                            size: 23,
                          ),
                          clearPadding: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8.5),
                          noSplash: true,
                          noHighlight: true,
                        ),
                      ],
                    ),
                    suffixIconPadding:
                        const EdgeInsetsDirectional.only(end: 10),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 40,
                    ),
                    // border: InputBorder.none,
                    side: const BorderSide(
                      color: Colors.amber,
                      width: 1,
                    ),
                    radius: 20,
                    borderStyle: MTextFieldBorderStyle.outline,
                    maxLines: 4,
                    minLines: 1,
                    isDense: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
