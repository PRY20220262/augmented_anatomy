import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  AuthService authService = AuthService();

  final passsword = TextEditingController();
  final passwordConfirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<String> _changePassword(email, newPassword) async {
    return await authService.changePassword(email, newPassword);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passsword.dispose();
    passwordConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AAAppBar(context, back: true),
        body: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                'Nueva Contraseña',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 30.0),
            PasswordInputLabel(
              label: 'Nueva contraseña',
              controller: passsword,
            ),
            const SizedBox(height: 15.0),
            PasswordInputLabel(
              label: 'Confirmar nueva contraseña',
              controller: passwordConfirm,
            ),
            const SizedBox(height: 25),
            MainActionButton(
                text: 'Enviar PIN',
                onPressed: () async {
                  bool validForm = _formKey.currentState!.validate();
                  if (validForm && (passsword.text == passwordConfirm.text)) {
                    String response =
                        await _changePassword(email, passsword.text);

                    if (response == '') {
                      Navigator.pushNamed(context, '/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                          AASnackBar.buildSnack(
                              context,
                              'Password actualizado correctamente',
                              SnackType.success));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          AASnackBar.buildSnack(
                              context,
                              'Ha ocurrido un error, intente nuevamente luego.',
                              SnackType.warning));
                    }
                  }
                  if (validForm && (passsword.text != passwordConfirm.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        AASnackBar.buildSnack(context,
                            'Las contraseñas no coinciden', SnackType.warning));
                  } else if (passsword.text != passwordConfirm.text) {}
                }),
          ]),
        ),
      ),
    );
  }
}
