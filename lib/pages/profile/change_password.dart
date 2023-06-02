import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  AuthService authService = AuthService();

  final oldPassword = TextEditingController();
  final passsword = TextEditingController();
  final passwordConfirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<String> _updateOwnPassword(oldPassword, newPassword) async {
    return await authService.changeOwnPassword(oldPassword, newPassword);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passsword.dispose();
    passwordConfirm.dispose();
    oldPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AAAppBar(context, back: true),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Text(
                      'Cambiar contraseña',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  PasswordInputLabel(
                    label: 'Contraseña antigua',
                    controller: oldPassword,
                  ),
                  const SizedBox(height: 15.0),
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
                  NewMainActionButton(
                      text: 'Confirmar',
                      onPressed: () async {
                        bool validForm = _formKey.currentState!.validate();
                        if (validForm &&
                            (passsword.text == passwordConfirm.text)) {
                          String response = await _updateOwnPassword(
                              oldPassword.text, passsword.text);

                          if (response == '') {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                AASnackBar.buildSnack(
                                    context,
                                    'Contraseña actualizada correctamente',
                                    SnackType.success));
                          } else if (response == 'invalid') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                AASnackBar.buildSnack(
                                    context,
                                    'Contraseña antigua inválida.',
                                    SnackType.warning));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                AASnackBar.buildSnack(
                                    context,
                                    'Ha ocurrido un error, intente nuevamente luego.',
                                    SnackType.warning));
                          }
                        }
                        if (validForm &&
                            (passsword.text != passwordConfirm.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              AASnackBar.buildSnack(
                                  context,
                                  'Las contraseñas no coinciden',
                                  SnackType.warning));
                        } else if (passsword.text != passwordConfirm.text) {}
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
