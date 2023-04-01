import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/widget.dart';
import 'package:flutter/material.dart';

class RequestPin extends StatelessWidget {
  RequestPin({super.key});

  AuthService authService = AuthService();

  void _requestPin() async {
    await authService.requestPin('s@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
          const InputLabel(
            label: 'Correo electrónico',
            hint: 'example@email.com',
          ),
          const SizedBox(height: 25),
          MainActionButton(
              text: 'Enviar PIN',
              onPressed: () {
                _requestPin();
                ScaffoldMessenger.of(context).showSnackBar(AASnackBar.buildSnack(
                    context,
                    'Si existe cuenta asociada, recibirá el PIN para recuperar su cuenta',
                    SnackType.success));
              })
        ]),
      ),
    );
  }
}
