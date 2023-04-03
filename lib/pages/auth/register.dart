import 'package:flutter/material.dart';

import '../../utils/augmented_anatomy_colors.dart';
import '../../utils/enums.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';
import '../../widgets/snackbar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // Properties

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String selectUserType = "Principiante";

  List<String> options = [
    'Estudiante primario',
    'Estudiante secundario',
    'Estudiante universitario',
    'Estudiante de medicina',
    'Profesional de la salud',
    'Profesional',
    'Principiante'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AAColors.backgroundWhiteView,
        appBar: AAAppBar(context, back: true),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Crear cuenta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InputLabel(
                        label: 'Nombre',
                        hint: 'Nombre y Apellidos',
                        controller: fullNameController,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InputLabel(
                        label: 'Correo electrónico',
                        hint: 'example@email.com',
                        controller: emailController,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InputLabel(
                        label: 'Teléfono',
                        hint: '999999999',
                        controller: phoneController,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: PasswordInputLabel(
                      label: 'Contraseña',
                      hint: '*****************',
                      controller: passwordController,
                    )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: PasswordInputLabel(
                      label: 'Confirmar contraseña',
                      hint: '*****************',
                      controller: confirmPasswordController,
                    )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: StudentDropdownButton(
                        label: 'Grado de eduación',
                        options: options,
                        initialValue: 'Principiante' ,
                        selectedOption: (String? newValue) {
                          setState(() {
                            selectUserType = newValue!;
                          });
                        }
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MainActionButton(
                      text: 'Registrarme',
                      onPressed: () {
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          AASnackBar.buildSnack(
                            context,
                            'Credenciales incorrectas. Intente nuevamente',
                            SnackType.error,
                          ),
                        );*/
                        print(selectUserType);
                      },
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '¿Ya tienes una cuenta?',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          TextActionButton(
                              text: 'Iniciar sesión',
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                          )
                        ],
                      )
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ));
  }
}
