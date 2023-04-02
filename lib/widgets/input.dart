import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  InputLabel({super.key, this.label, this.hint, required this.controller});

  final String? label;
  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width - size.width * 0.90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(label!,
                      style: Theme.of(context).textTheme.labelLarge),
                )
              : const SizedBox(),
          TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputLabel extends StatefulWidget {
  PasswordInputLabel({Key? key, this.label, this.hint, required this.controller})
      : super(key: key);

  final String? label;
  final String? hint;
  final TextEditingController controller;

  @override
  _PasswordInputLabelState createState() => _PasswordInputLabelState();
}

class _PasswordInputLabelState extends State<PasswordInputLabel> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width - size.width * 0.90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(widget.label!,
                style: Theme.of(context).textTheme.labelLarge),
          )
              : const SizedBox(),
          TextFormField(
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _obscureText,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}