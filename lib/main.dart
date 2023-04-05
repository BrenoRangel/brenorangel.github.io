import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'home_page.dart';
import 'theming.dart';

void main() {
  usePathUrlStrategy();
  runApp(const PortifolioApp());
}

ThemeMode _themeMode = ThemeMode.light;

class PortifolioApp extends StatefulWidget {
  const PortifolioApp({super.key});

  @override
  State<PortifolioApp> createState() => _PortifolioAppState();

  static _PortifolioAppState of(BuildContext context) => context.findAncestorStateOfType<_PortifolioAppState>()!;
}

class _PortifolioAppState extends State<PortifolioApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portifólio | Breno Rangel',
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
