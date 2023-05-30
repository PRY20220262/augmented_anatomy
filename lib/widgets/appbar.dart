import 'package:flutter/material.dart';

PreferredSizeWidget AAAppBar(BuildContext context,
    {required bool back, String? title, Function()? onPressed}) {
  return AppBar(
    toolbarHeight: 90,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        : null,
    centerTitle: true,
    leadingWidth: 70,
    leading: back
        ? Align(
            child: Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
              ),
            ),
          )
        : null,
  );
}