import 'package:flutter/material.dart';


TextTheme getAATextTheme() {
  return const TextTheme(
    titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),

    labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),

    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    
  );
}
