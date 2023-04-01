import 'dart:ffi';

import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const MainActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AAColors.red,
            foregroundColor: AAColors.white,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(text),
        )
    );
  }
}