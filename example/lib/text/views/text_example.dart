import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class MTextExample extends StatelessWidget {
  const MTextExample({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('MText Example'),
      ),
      body: Builder(builder: (context) {
        final style = DefaultTextStyle.of(context).style;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Spacer(),
                const Text(
                  'Text',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  textScaler: TextScaler.noScaling,
                ),
                const Spacer(),
                const MText(
                  'MText',
                  color: Colors.amber,
                  fontSize: 20,
                ),
                const Spacer(),
                RichText(
                  text: const TextSpan(
                    text: 'RichText',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Text(
              'Hello World!!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const MText(
              'Hello World!!',
              color: Colors.amber,
              isBold: true,
              fontSize: 30,
            ),
            const MText.rich(
              color: Colors.red,
              isBold: true,
              fontSize: 20,
              children: [
                MTextSpan(text: 'Hello World,'),
                MTextSpan(
                  text: 'I am RichText',
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ],
            ),
            const Text.rich(
              TextSpan(
                children: [
                  MTextSpan(text: 'Hello World,'),
                  MTextSpan(
                    text: 'I am RichText',
                    color: Colors.blue,
                    fontSize: 30,
                  ),
                ],
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textScaler: TextScaler.noScaling,
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  MTextSpan(text: 'Hello World,'),
                  TextSpan(
                    text: 'I am RichText',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            MRichText.children(
              children: const [
                MTextSpan(text: 'Hello World,'),
                MTextSpan(
                  text: 'I am RichText',
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ],
              color: Colors.red,
              isBold: true,
              fontSize: 20,
            ),
            const Text(
              'Hello World!!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
              textScaler: TextScaler.noScaling,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello World!!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: style.copyWith(
                fontSize: 16,
                backgroundColor: Colors.amber,
              ),
              child: MContainer(
                color: Colors.grey,
                margin: const EdgeInsets.all(20),
                child: const MText(
                  '发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~',
                  style: MTextStyle(
                    lineHeight: 60,
                    // fontSize: 20,
                  ),
                  // lineHeight: 60,
                  // fontSize: 20,
                ),
              ),
            ),
            MContainer(
              color: Colors.grey,
              margin: const EdgeInsets.all(20),
              child: const Text(
                '发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~,发送失败，今日免费聊天数已用完， 充值或开通VIP都可以继续嗨聊，付出 也是您提现诚意的一种方式哦~快去试 试吧，别错过缘分~',
                style: TextStyle(
                  height: 60 / 16.0,
                  fontSize: 16,
                  backgroundColor: Colors.amber,
                ),
              ),
            ),
          ],
        );
      }
      ),
    );
  }
}
