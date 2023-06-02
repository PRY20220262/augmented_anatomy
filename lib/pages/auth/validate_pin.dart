import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

class ValidatePin extends StatefulWidget {
  ValidatePin({super.key});

  @override
  State<ValidatePin> createState() => _ValidatePinState();
}

class _ValidatePinState extends State<ValidatePin> {
  AuthService authService = AuthService();
  String response = 'AAAA';

  String pin = '';

  Future<String> _validatePin(email, pin) async {
    return await authService.validatePIN(email, pin);
  }

  void _updatePin(String newPin) {
    setState(() {
      pin = newPin;
      print(pin);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AAAppBar(context, back: true),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: size.width * 0.8,
            child: Text(
              'Verificación',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 30.0),
          PinInput(
            callback: _updatePin,
          ),
          const SizedBox(height: 25),
          NewMainActionButton(
              text: 'Verficar',
              onPressed: () async {
                response = await _validatePin(email, pin);
                print(response);
                if (response == '') {
                  //NAVIGATE TO CHANGE PASSWORD
                  Navigator.pushNamed(context, '/update-password',
                      arguments: email);

                  ScaffoldMessenger.of(context).showSnackBar(
                      AASnackBar.buildSnack(
                          context,
                          'PIN correcto, ingrese nueva contraseña',
                          SnackType.success));
                } else if (response == 'invalid') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      AASnackBar.buildSnack(
                          context,
                          'PIN inválido, Intente nuevamente.',
                          SnackType.warning));
                } else if (response == 'error') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      AASnackBar.buildSnack(
                          context,
                          'Algo salió mal. Intente nuevamente luego.',
                          SnackType.warning));
                }
              })
        ]),
      ),
    );
  }
}
