import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeSelector {
  static ThemeData themeData(String theme, BuildContext context) {
    Color primaryColor;
    Color secondaryColor;
    Color accentColor;

    if (theme == 'BLUE') {
      primaryColor = const Color(0xFF0074B7);
      secondaryColor = const Color(0xFFBFD7ED);
      accentColor = const Color(0xFF003B73);
    } else if (theme == 'RED') {
      primaryColor = const Color(0xFFef3340);
      secondaryColor = const Color(0xFFEBECE0);
      accentColor = const Color(0xFFAA1945);
    } else if (theme == 'YELLOW') {
      primaryColor = const Color(0xFFffd600);
      secondaryColor = const Color(0xFFffebe3);
      accentColor = const Color(0xFFff6c34);
    } else if (theme == 'GREEN') {
      primaryColor = const Color(0xFF18A558);
      secondaryColor = const Color(0xFFA3EBB1);
      accentColor = const Color(0xFF21B6A8);
    } else if (theme == 'PURPLE') {
      primaryColor = const Color(0xFF9505E3);
      secondaryColor = const Color(0xFFB4FEE7);
      accentColor = const Color(0xFF3D393B);
    } else {
      primaryColor = const Color(0xFF9505E3);
      secondaryColor = const Color(0xFFB4FEE7);
      accentColor = const Color(0xFF3D393B);
    }
    return ThemeData(
      primaryColor: primaryColor,
      secondaryHeaderColor: secondaryColor,
      accentColor: accentColor,
    );
  }
}
