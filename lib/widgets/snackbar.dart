import 'package:augmented_anatomy/utils/enums.dart';
import 'package:flutter/material.dart';
import '../utils/augmented_anatomy_colors.dart';

class AASnackBar {
  const AASnackBar();

  static buildSnack(BuildContext context, String message, SnackType type) {
    Color color;

    switch (type) {
      case SnackType.error:
        color = AAColors.red;
        break;
      case SnackType.success:
        color = AAColors.green;
        break;
      case SnackType.warning:
        color = AAColors.amber;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            ),
            Expanded(
                child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ))
          ],
        ),
      ),
    );
  }
}
