import 'package:augmented_anatomy/models/user_save_resource.dart';
import 'package:flutter/material.dart';

import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Properties

  final _formKeyRegister = GlobalKey<FormState>();
  final authService = AuthService();
  bool enableRegister = false;
  String messageRequest = "";
  var manageResult = SnackType.warning;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String selectUserType = "BEGINNER_USER";
  final options = {
    'Estudiante primario': 'PRIMARY_STUDENT',
    'Estudiante secundario': 'SECONDARY_STUDENT',
    'Estudiante universitario': 'UNIVERSITY_STUDENT',
    'Estudiante de medicina': 'MEDICINE_STUDENT',
    'Profesional de la salud': 'MEDICINE_PROFESSIONAL',
    'Profesional': 'PROFESSIONAL',
    'Principiante': 'BEGINNER_USER'
  };

  // Functions

  Future<void> registerUser(bool enableForm, BuildContext context,
      UserRegisterModel userRegisterModel) async {
    if (enableForm) {
      if (userRegisterModel.password == userRegisterModel.confirmPassword) {
        messageRequest = await authService.register(userRegisterModel);
        if (messageRequest == 'Registro exitoso') {
          setState(() {
            manageResult = SnackType.success;
          });
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (Route<dynamic> route) => false,
          );
        } else {
          setState(() {
            manageResult = SnackType.error;
          });
        }
      } else {
        messageRequest = 'Las contraseñas no coinciden.';
      }
    } else {
      messageRequest = 'Los valores ingresados son erroneos.';
      setState(() {
        manageResult = SnackType.warning;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      AASnackBar.buildSnack(
        context,
        messageRequest,
        manageResult,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AAAppBar(context, back: true),
        backgroundColor: AAColors.backgroundWhiteView,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKeyRegister,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Crear cuenta',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InputLabel(
                            label: 'Nombre',
                            hint: 'Nombre y Apellidos',
                            keyboardType: TextInputType.name,
                            controller: fullNameController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: InputLabel(
                            label: 'Correo electrónico',
                            hint: 'example@email.com',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: InputLabel(
                            label: 'Teléfono',
                            hint: '999999999',
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: PasswordInputLabel(
                            label: 'Contraseña',
                            hint: '*****************',
                            controller: passwordController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: PasswordInputLabel(
                            label: 'Confirmar contraseña',
                            hint: '*****************',
                            controller: confirmPasswordController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: AADropdownButton(
                              label: 'Grado de eduación',
                              options: options,
                              initialValue: selectUserType,
                              selectedOption: (String? newValue) {
                                setState(() {
                                  selectUserType = newValue!;
                                });
                              })),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: NewMainActionButton(
                          text: 'Registrarme',
                          onPressed: () {
                            bool validForm =
                                _formKeyRegister.currentState!.validate();
                            registerUser(
                                validForm,
                                context,
                                UserRegisterModel(
                                    emailController.text,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                    phoneController.text,
                                    fullNameController.text,
                                    selectUserType));
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿Aun no tienes cuenta?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 30),
                              NewTextActionButton(
                                  text: 'Iniciar sesión',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  })
                            ],
                          )),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                )),
          ),
        ));
  }
}
