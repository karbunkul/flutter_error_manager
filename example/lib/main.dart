import 'package:error_manager/error_manager.dart';
import 'package:example/actions/material_banner_action.dart';
import 'package:example/views/network_error_view.dart';
import 'package:example/views/requirement_error_view.dart';
import 'package:example/views/timeout_error.dart';
import 'package:flutter/material.dart';

import 'demo_page.dart';

part 'handlers.dart';
part 'layouts.dart';
part 'manager.dart';
part 'views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const DemoPage(),
      builder: (context, child) {
        return _ErrorManager(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
