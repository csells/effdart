import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import '../gen/assets.gen.dart';
import '../views/chat_view.dart';
import '../views/markdown_from_asset_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _sections = [
    'Overview',
    'Style',
    'Documentation',
    'Design',
    'Summary',
  ];

  var _selectedIndex = 0;
  var _showChat = false;
  static const _title = 'Effective Dart';

  final _controller = SplitViewController(
    weights: [0.7, 0.3],
    limits: [
      WeightLimit(min: 0.3, max: 0.7),
      WeightLimit(min: 0.3, max: 0.7),
    ],
  );

  // splitter look 'n' feel inspired by:
  // https://medium.com/@leonar.d/how-to-create-a-flutter-split-view-7e2ac700ea12
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            // disable AppBar color change on scroll
            forceMaterialTransparency: true,
            title: const Text(_title),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.toc),
                tooltip: 'Table of Contents',
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => setState(() => _showChat = !_showChat),
                icon: const Icon(Icons.chat_bubble_outline),
                selectedIcon: const Icon(Icons.chat_bubble),
                isSelected: _showChat,
                tooltip: _showChat ? 'Hide Chat Panel' : 'Show Chat Panel',
              ),
            ]),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              for (final i in _sections.indexed)
                ListTile(
                  title: Text(i.$2),
                  selected: _selectedIndex == i.$1,
                  onTap: () {
                    setState(() => _selectedIndex = i.$1);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
        body: _showChat
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: SplitView(
                  viewMode: SplitViewMode.Horizontal,
                  controller: _controller,
                  gripColor: Colors.transparent,
                  gripColorActive: const Color.fromARGB(10, 0, 0, 0),
                  indicator: Transform.rotate(
                    angle: 1.5708, // 90 degrees * π/180
                    child: const Icon(
                      Icons.drag_handle,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    FramedBox(
                      child: MarkdownFromAssetView(Assets.bookContent.index),
                    ),
                    const FramedBox(
                      child: ChatView(),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: FramedBox(
                  child: MarkdownFromAssetView(Assets.bookContent.index),
                ),
              ),
      );
}

class FramedBox extends StatelessWidget {
  const FramedBox({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: child,
      );
}
