import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'home_page.dart';
import 'theming.dart';

void main() {
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

ThemeMode _themeMode = ThemeMode.light;

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();

  static _PortfolioAppState of(BuildContext context) => context.findAncestorStateOfType<_PortfolioAppState>()!;
}

class _PortfolioAppState extends State<PortfolioApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio | Breno Rangel',
      theme: buildTheme(_themeMode),
      themeMode: _themeMode,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
