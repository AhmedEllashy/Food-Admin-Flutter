import 'package:flutter/material.dart';

import 'color_manager.dart';


ThemeData getAppTheme(){
  return ThemeData(
  primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
color: AppColors.primary,
    ),
    // canvasColor: Colors.white10,

    elevatedButtonTheme:  ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
      ),
    ),
  );
}