import 'package:flutter/material.dart';

class AppTheme{

  // light theme

  static final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF006837)),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // Ensures white AppBar
    foregroundColor: Colors.black, // Ensures black text/icons
    elevation: 0, // Removes shadow
  ),
  );

}