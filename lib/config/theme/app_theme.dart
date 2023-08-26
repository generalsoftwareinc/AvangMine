import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';

class AppTheme {
  final bool isDarkmode;
  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: indigo,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme:
            ListTileThemeData(iconColor: isDarkmode ? indigo : Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
