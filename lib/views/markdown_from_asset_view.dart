import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../app_future_builder.dart';

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
