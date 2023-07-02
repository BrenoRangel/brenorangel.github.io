import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:named_html_color/html_color.dart';

//const color = Color(0xFF0077B7);
//const color = Colors.grey;
const color = HTMLColor.dodgerBlue;

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

final roundButtonStyle = ElevatedButton.styleFrom(
  shape: const CircleBorder(),
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: const Size.square(40),
  maximumSize: const Size.square(40),
);
