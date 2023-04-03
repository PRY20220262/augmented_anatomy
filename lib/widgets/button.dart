import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';

import 'input.dart';

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
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AAColors.red
          ),
        )
    );
  }
}

typedef void OnChangedCallback(String? newValue);

class StudentDropdownButton extends StatefulWidget {


  StudentDropdownButton({
    Key? key,
    required this.label,
    required this.options,
    required this.initialValue,
    required this.selectedOption,
  }) : super(key: key);

  final String? label;
  final List<String> options;
  final String initialValue;
  final OnChangedCallback? selectedOption;

  @override
  _StudentDropdownButton createState() => _StudentDropdownButton();
}


class _StudentDropdownButton extends State<StudentDropdownButton> {

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
        padding: EdgeInsets.symmetric(horizontal: size.width - size.width * 0.90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(widget.label!,
                  style: Theme.of(context).textTheme.labelLarge),
            ),
            InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                    items: widget.options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  isExpanded: true,
                    underline: SizedBox.shrink()
                  ),
            )
          ],
        )
    );
  }
}