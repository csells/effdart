import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:split_view/split_view.dart';

import 'app_future_builder.dart';
import 'gen/assets.gen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({super.key});

  static const title = 'Effective Dart';

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      );
}

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
            title: const Text(App.title),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.toc),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => setState(() => _showChat = !_showChat),
                icon: const Icon(Icons.chat),
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 500),
                    child: const ColoredBox(
                      color: Colors.blue,
                      child: Text('TODO: Chat'),
                    ),
                  ),
                ],
              )
            : MarkdownFromAssetView(Assets.bookContent.index),
      );
}

// TODO: implement support for links
class MarkdownFromAssetView extends StatelessWidget {
  const MarkdownFromAssetView(this.assetPath, {super.key});

  final String assetPath;

  @override
  Widget build(BuildContext context) => AppFutureBuilder<String>(
        // ignore: discarded_futures
        future: _loadMarkdown(assetPath),
        builder: (context, data) => Markdown(data: data),
      );

  // TODO: implement %include from index.md
  // TODO: implement %comment/endcomment from _toc.md
  Future<String> _loadMarkdown(String assetPath) async {
    final md = await rootBundle.loadString(assetPath);
    // remove markdown annotations
    return md.replaceFirst(RegExp(r'^---[\s\S]*?---\s*'), '');
  }
}
