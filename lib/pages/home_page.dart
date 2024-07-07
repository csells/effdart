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
  static const _chatPanelWeight = 0.3;
  static const _title = 'Effective Dart';

  final _controller = SplitViewController(
    weights: [1.0 - _chatPanelWeight, _chatPanelWeight],
    limits: [
      WeightLimit(min: 0.3, max: 0.7),
      WeightLimit(min: 0.3, max: 0.7),
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
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
            ? SplitView(
                viewMode: SplitViewMode.Horizontal,
                controller: _controller,
                indicator: Transform.rotate(
                  angle: 1.5708, // 90 degrees * π/180
                  child: const Icon(
                    Icons.drag_handle,
                    color: Colors.white,
                  ),
                ),
                children: [
                  MarkdownFromAssetView(Assets.bookContent.index),
                  const ChatView(),
                ],
              )
            : MarkdownFromAssetView(Assets.bookContent.index),
      );
}
