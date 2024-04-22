import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_widget/sm_widget.dart';

class MTextFieldExample01 extends StatefulWidget {
  const MTextFieldExample01({super.key});

  @override
  State<MTextFieldExample01> createState() => _MTextFieldExample01State();
}

class _MTextFieldExample01State extends State<MTextFieldExample01> {
  final _text = ''.obs;
  String get text => _text.value;
  set text(val) {
    _text.value = val;

    if (val.isEmpty) {
      textController.clear();
    } else {
      textController.text = val;
    }
  }

  final _showSendSoundText = false.obs;
  get showSendSoundText => _showSendSoundText.value;

  set showSendSoundText(val) {
    if (val) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
    _showSendSoundText.value = val;
  }

  set showEmojiPanel(bool val) {
    if (val) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
    _showEmojiPanel.value = val;
  }

  late FocusNode focusNode;
  late final textController = TextEditingController();
  final _showEmojiPanel = false.obs;
  bool get showEmojiPanel => _showEmojiPanel.value;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      title: 'MTextFieldExample01',
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
            Row(
              children: [
                const SizedBox(width: 10),
                MIconButton(
                  onPressed: () => showSendSoundText = !showSendSoundText,
                  icon: const MImage(
                    'assets/images/avatar.png',
                    width: 22,
                    height: 28,
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: showSendSoundText
                        ? const Center(child: MText('长按说话...'))
                        : MTextField(
                            controller: textController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: '请输入消息...',
                              hintStyle: const TextStyle(
                                color: Color(0xFFD0D0D0),
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MIconButton(
                                    onPressed: () {
                                      _onCursorChange();
                                      showEmojiPanel = !showEmojiPanel;
                                    },
                                    icon: Icon(showEmojiPanel ? Icons.keyboard : Icons.emoji_emotions),
                                    clearPadding: true,
                                    clearSplash: true,
                                    clearOverlay: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8.5),
                                  ),
                                  MIconButton(
                                    onPressed: () {},
                                    icon: ValueListenableBuilder(
                                      valueListenable: textController,
                                      builder: (BuildContext context, TextEditingValue value, Widget? child) {
                                        return Icon(
                                          Icons.send,
                                          color: value.text.isNotEmpty ? Colors.blue : Colors.grey,
                                        );
                                      },
                                    ),
                                    clearPadding: true,
                                    clearSplash: true,
                                    clearOverlay: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8.5),
                                  ),
                                  const SizedBox(width: 12.5),
                                ],
                              ),
                              // suffixIconPadding: const EdgeInsetsDirectional.only(end: 12.5),
                              suffixIconConstraints: const BoxConstraints(maxHeight: 40),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              isDense: true,
                            ),
                            maxLines: 4,
                            minLines: 1,
                            onSubmitted: (value) {},
                            onTap: () {
                              showEmojiPanel = false;
                            },
                            textInputAction: TextInputAction.send,
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  int? currentCursor;

  _onCursorChange() {
    final selection = textController.selection;
    currentCursor = selection.baseOffset;
  }
}
