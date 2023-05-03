import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:flutter/material.dart';

import 'input.dart';

class MainActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final ButtonType? type;

  const MainActionButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.width,
      this.height,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: type == ButtonType.secondary
                        ? Colors.black
                        : AAColors.red),
                borderRadius: BorderRadius.circular(10.0)),
            elevation: type == ButtonType.secondary ? 0 : 1,
            backgroundColor: type == ButtonType.secondary
                ? Colors.transparent
                : AAColors.red,
            foregroundColor: AAColors.white,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(text,
              style: TextStyle(
                  color: type == ButtonType.secondary
                      ? Colors.black
                      : Colors.white)),
        ));
  }
}

class NotAllowedActionButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;

  const NotAllowedActionButton(
      {Key? key,
        required this.text,
        this.width,
        this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 1,
            backgroundColor: AAColors.gray,
            foregroundColor: AAColors.white,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white)),
        ));
  }
}

class TextActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AAColors.red),
        ));
  }
}

typedef void OnChangedCallback(String? newValue);

class AADropdownButton extends StatefulWidget {
  AADropdownButton({
    Key? key,
    this.label,
    this.width,
    required this.options,
    required this.initialValue,
    required this.selectedOption,
  }) : super(key: key);

  final String? label;
  final num? width;
  final Map<String, String> options;
  final String initialValue;
  final OnChangedCallback? selectedOption;

  @override
  _AADropdownButton createState() => _AADropdownButton();
}

class _AADropdownButton extends State<AADropdownButton> {
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: widget.width == null
            ? EdgeInsets.symmetric(horizontal: size.width - size.width * 0.90)
            : EdgeInsets.symmetric(
                horizontal: size.width - size.width * widget.width!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.label != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.label!,
                        style: Theme.of(context).textTheme.labelLarge),
                  )
                : Container(),
            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                focusColor: Colors.black,
              ),
              child: DropdownButton<String>(
                value: _dropdownValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _dropdownValue = newValue;
                    });
                    widget.selectedOption!(newValue);
                  }
                },
                items: widget.options.entries
                    .map((MapEntry<String, String> entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                style: Theme.of(context).textTheme.bodyMedium,
                isExpanded: true,
                underline: SizedBox.shrink(),
              ),
            )
          ],
        ));
  }
}
