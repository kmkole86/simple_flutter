import 'package:flutter/material.dart';

import 'features/feed/page/feed_page.dart';
import 'injection_container.dart';

void main() async {
  init();
  await di.allReady();
  runApp(const SimpleApp());
}

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PopularMoviesPage(),
    );
  }
}
