import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light);
final darkColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

final scrollbarTheme = ScrollbarThemeData(thickness: MaterialStateProperty.all(4));

ThemeData buildTheme(ThemeMode themeMode) {
  final colorScheme = themeMode == ThemeMode.light ? lightColorScheme : darkColorScheme;

  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scrollbarTheme: scrollbarTheme,
  );

  return theme.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(theme.textTheme),
    cardTheme: theme.cardTheme.copyWith(margin: EdgeInsets.zero),
  );
}
