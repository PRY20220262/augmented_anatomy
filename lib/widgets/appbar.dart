import 'package:flutter/material.dart';

PreferredSizeWidget AAAppBar(BuildContext context, {required bool back}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: back
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )
        : null,
  );
}
