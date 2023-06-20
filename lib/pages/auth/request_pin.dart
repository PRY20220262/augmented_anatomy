import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

class RequestPin extends StatefulWidget {
  RequestPin({super.key});

  @override
  State<RequestPin> createState() => _RequestPinState();
}

class _RequestPinState extends State<RequestPin> {
  AuthService authService = AuthService();

  final emailController = TextEditingController();

  void _requestPin() async {
    await authService.requestPin(emailController.text);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AAAppBar(context, back: true),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: size.width * 0.8,
            child: Text(
              '¿Olvidaste tu contraseña?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 30.0),
          InputLabel(
            label: 'Correo electrónico',
            hint: 'example@email.com',
            controller: emailController,
          ),
          const SizedBox(height: 25),
          NewMainActionButton(
              text: 'Enviar PIN',
              onPressed: () {
                _requestPin();
                Navigator.pushNamed(context, '/validate-pin',
                    arguments: emailController.text);

                ScaffoldMessenger.of(context).showSnackBar(AASnackBar.buildSnack(
                    context,
                    'Si existe cuenta asociada, recibirá el PIN para recuperar su cuenta',
                    SnackType.success));
              }),
        ]),
      ),
    );
  }
}
