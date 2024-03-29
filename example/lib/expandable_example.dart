import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

class ExpandableExample extends StatelessWidget {
  const ExpandableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MText('MExpandable'),
      ),
      body: MExpandableTheme(
        data: const MExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[
            Card0(),
            Card1(),
            Card2(),
            Card3(),
            Card4(),
          ],
        ),
      ),
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card0 extends StatelessWidget {
  const Card0({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        child: MExpandablePanel(
          theme: MExpandableThemeData(
            tapHeaderToExpand: true,
            hasIcon: true,
            headerAlignment: MExpandablePanelHeaderAlignment.center,
          ),
          header: MText('This is a header'),
          collapsed: MText(
            loremIpsum,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          expanded: MText(
            loremIpsum,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return MExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              MScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: MExpandablePanel(
                  theme: const MExpandableThemeData(
                    headerAlignment: MExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "ExpandablePanel",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  collapsed: const Text(
                    loremIpsum,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(5))
                        const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsum,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: MExpandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const MExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
            ),
          ));
    }

    buildCollapsed1() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Expandable",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Expandable",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "3 Expandable widgets",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              loremIpsum,
              softWrap: true,
            ),
          ],
        ),
      );
    }

    return MExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: MScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MExpandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              MExpandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              MExpandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller = MExpandableController.of(context, required: true)!;
                      return TextButton(
                        child: Text(
                          controller.expanded ? "COLLAPSE" : "EXPAND",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.deepPurple),
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList() {
      return Column(
        children: <Widget>[
          for (var i in [1, 2, 3, 4]) buildItem("Item $i"),
        ],
      );
    }

    return MExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: MScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              MExpandablePanel(
                theme: const MExpandableThemeData(
                  headerAlignment: MExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: Colors.indigoAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const MExpandableIcon(
                          theme: MExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Items",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card4 extends StatelessWidget {
  const Card4({super.key});

  @override
  Widget build(BuildContext context) {
    return MExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MScrollOnExpand(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        MExpandable(
                          theme: MExpandableThemeData(
                            transition: MExpandableTransition.size,
                          ),
                          collapsed: MCircleAvatar(
                            source: 'assets/images/avatar.png',
                            radius: 30,
                          ),
                          expanded: MCircleAvatar(
                            source: 'assets/images/avatar.png',
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                    const MExpandable(
                      theme: MExpandableThemeData(transition: MExpandableTransition.size),
                      collapsed: SizedBox.shrink(),
                      expanded: Text(loremIpsum),
                    ),
                    Row(
                      children: [
                        MExpandable(
                          theme: const MExpandableThemeData(transition: MExpandableTransition.opacity),
                          collapsed: const SizedBox.shrink(),
                          expanded: MContainer(
                            color: Colors.blue,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Builder(
                  builder: (context) {
                    var controller = MExpandableController.of(context, required: true)!;
                    return MButton(
                      child: MText(
                        controller.expanded ? "COLLAPSE" : "EXPAND",
                      ),
                      onPressed: () {
                        controller.toggle();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
