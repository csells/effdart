// import 'dart:developer' as dev;

import 'package:flutter/material.dart';

typedef WidgetBuilderWithData<T> = Widget Function(
    BuildContext context, T data);

class AppFutureBuilder<T extends Object> extends StatelessWidget {
  const AppFutureBuilder({
    required this.future,
    required this.builder,
    super.key,
  });

  final Future<T> future;
  final WidgetBuilderWithData<T> builder;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        // dev.log('connectionState= ${snapshot.connectionState}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Scaffold(
                body: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            return builder(context, snapshot.data!);
        }
      });
}
