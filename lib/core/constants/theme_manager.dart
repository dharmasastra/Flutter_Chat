import 'package:flutter/material.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue[200]),
    primaryColor: Colors.blue[200],
  );
}
