import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//const color = Color(0xFF0077B7);
const color = Colors.grey;

const scrollbarTheme = ScrollbarThemeData(
  thumbVisibility: MaterialStatePropertyAll(true),
  thickness: MaterialStatePropertyAll(4),
  radius: Radius.zero,
  thumbColor: MaterialStatePropertyAll(color),
);
final darkColorScheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark);

final lightColorScheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light);

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

getConstraints(BuildContext context) => BoxConstraints(
      maxHeight: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
