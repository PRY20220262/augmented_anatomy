import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputLabel extends StatelessWidget {
  InputLabel(
      {super.key,
      this.label,
      this.hint,
      this.keyboardType,
      required this.controller});

  final String? label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  String? updateValue(String? value, TextInputType? keyboardType) {
    if (keyboardType == TextInputType.name) {
      if (value == null ||
          value.isEmpty ||
          value.trim().split(' ').length < 2) {
        return 'Ingrese su nombre completo';
      } else if (!RegExp(r'^[a-zA-Z]+(\s[a-zA-Z]+)+$').hasMatch(value)) {
        return 'Ingrese un nombre válido';
      }
    } else if (keyboardType == TextInputType.emailAddress) {
      if (value == null || value.isEmpty) {
        return 'Ingrese su correo electrónico';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Ingrese un correo valido';
      }
    } else if (keyboardType == TextInputType.phone) {
      if (value == null || value.isEmpty) {
        return 'Ingrese su número de teléfono';
      } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
        return 'Ingrese un número de teléfono válido (9 dígitos)';
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width - size.width * 0.90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            cursorColor: Colors.black45,
            style: Theme.of(context).textTheme.bodyLarge,
            validator: (value) {
              return updateValue(value, keyboardType);
            },
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
              labelText: label,
              hintText: hint,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AAColors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionInput extends StatelessWidget {
  DescriptionInput(
      {super.key, this.label, this.hint, required this.controller});

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
          TextFormField(
            controller: controller,
            minLines: 1,
            maxLines: 10, // allow user to enter 5 line in textfield
            keyboardType: TextInputType.multiline,
            style: Theme.of(context).textTheme.bodyMedium,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: hint,
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputLabel extends StatefulWidget {
  PasswordInputLabel(
      {Key? key, this.isLogin, this.label, this.hint, required this.controller})
      : super(key: key);

  final bool? isLogin;
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
          TextFormField(
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyLarge,
            validator: (value) {
              if (widget.isLogin == null) {
                if (value == null || value.isEmpty) {
                  return 'Por favor complete los campos';
                }
                if (value.length < 6) {
                  return 'El campo debe ser mayor a 6 dígitos';
                }
              } else if (widget.isLogin == true) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña';
                }
              } else {
                return null;
              }
              return null;
            },
            obscureText: _obscureText,
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
              labelText: widget.label ?? 'Contraseña',
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AAColors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
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

class PinInput extends StatefulWidget {
  PinInput({super.key, required this.callback});

  final Function(String) callback;

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late String pin1 = '';
  late String pin2 = '';
  late String pin3 = '';
  late String pin4 = '';
  late String pin;

  void updatePin() {
    setState(() {
      pin = pin1 + pin2 + pin3 + pin4;
      widget.callback(pin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (value) {
              setState(() {
                pin1 = value;
                updatePin();
              });
              if (value.length == 1) FocusScope.of(context).nextFocus();
            },
            cursorColor: Colors.black38,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AAColors.mainColor)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            // style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (value) {
              setState(() {
                pin2 = value;
                updatePin();
              });
              if (value.length == 1) FocusScope.of(context).nextFocus();
            },
            cursorColor: Colors.black38,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            // style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (value) {
              pin3 = value;
              updatePin();
              if (value.length == 1) FocusScope.of(context).nextFocus();
            },
            cursorColor: Colors.black38,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            // style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (value) {
              pin4 = value;
              updatePin();
              if (value.length == 1) FocusScope.of(context).nextFocus();
            },
            cursorColor: Colors.black38,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            // style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        )
      ]),
    );
  }
}
