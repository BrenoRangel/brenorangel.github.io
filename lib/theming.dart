import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//const color = Color(0xFF0077B7);
const color = Colors.grey;

final lightColorScheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light);
final darkColorScheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark);

const scrollbarTheme = ScrollbarThemeData(
  thumbVisibility: MaterialStatePropertyAll(true),
  thickness: MaterialStatePropertyAll(4),
  radius: Radius.zero,
  thumbColor: MaterialStatePropertyAll(color),
);

ThemeData buildTheme(ThemeMode themeMode) {
  final colorScheme = themeMode == ThemeMode.light ? lightColorScheme : darkColorScheme;

  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scrollbarTheme: scrollbarTheme.copyWith(
      thumbColor: MaterialStatePropertyAll(colorScheme.secondary),
    ),
  );

  return theme.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(theme.textTheme),
    cardTheme: theme.cardTheme.copyWith(margin: EdgeInsets.zero),
  );
}
