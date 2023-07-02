import 'package:flutter/material.dart';

class ColorMap {
  static final Map<int, Map<int, int>> _colorToHue = {};

  static getColorToHue() {
    if (_colorToHue.isEmpty) {
      for (MaterialColor materialColor in Colors.primaries) {
        _colorToHue.putIfAbsent(
            materialColor.value,
            () => {
                  50: materialColor.shade50.value,
                  100: materialColor.shade100.value,
                  200: materialColor.shade200.value,
                  300: materialColor.shade300.value,
                  400: materialColor.shade400.value,
                  500: materialColor.shade500.value,
                  600: materialColor.shade600.value,
                  700: materialColor.shade700.value,
                  800: materialColor.shade800.value,
                  900: materialColor.shade900.value,
                });
      }
      _colorToHue.putIfAbsent(
          Colors.grey.value,
          () => {
                50: Colors.grey.shade50.value,
                100: Colors.grey.shade100.value,
                200: Colors.grey.shade200.value,
                300: Colors.grey.shade300.value,
                350: Colors.grey[350]!.value,
                400: Colors.grey.shade400.value,
                500: Colors.grey.shade500.value,
                600: Colors.grey.shade600.value,
                700: Colors.grey.shade700.value,
                800: Colors.grey.shade800.value,
                850: Colors.grey[850]!.value,
                900: Colors.grey.shade900.value,
              });
      _colorToHue.putIfAbsent(
          Colors.black.value,
          () => {
                12: Colors.black12.value,
                26: Colors.black26.value,
                38: Colors.black38.value,
                45: Colors.black45.value,
                54: Colors.black54.value,
                87: Colors.black87.value,
                100: Colors.black.value,
              });
      _colorToHue.putIfAbsent(
          Colors.white.value,
          () => {
                10: Colors.white10.value,
                12: Colors.white12.value,
                24: Colors.white24.value,
                30: Colors.white30.value,
                38: Colors.white38.value,
                54: Colors.white54.value,
                60: Colors.white60.value,
                70: Colors.white70.value,
                100: Colors.white.value,
              });
    }
    return _colorToHue;
  }
}
