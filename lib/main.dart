import 'package:flutter/material.dart';
import 'package:merchok/routing/router.dart';
import 'package:merchok/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router, theme: theme);
  }
}
