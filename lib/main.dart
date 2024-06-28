import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

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
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: MarkdownAssetPage(Assets.bookContent.index),
      );
}

// TODO: implement support for links
class MarkdownAssetPage extends StatelessWidget {
  const MarkdownAssetPage(this.assetPath, {super.key});

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
