import 'package:augmented_anatomy/models/user.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
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

  bool validateInput(UserRegisterModel userRegisterModel){
    if (userRegisterModel.fullName == '' ||
        userRegisterModel.email == '' ||
        userRegisterModel.phone == '' ||
        userRegisterModel.password == '' ||
        userRegisterModel.confirmPassword == '' ||
        userRegisterModel.userType == ''){
      return false;
    } else {
      return userRegisterModel.password == userRegisterModel.confirmPassword;
    }
  }

  Future<void> registerUser(BuildContext context, UserRegisterModel userRegisterModel) async {
    enableRegister = validateInput(userRegisterModel);
    if (enableRegister) {
      messageRequest = await authService.register(userRegisterModel);
      if(messageRequest == 'Registro exitoso') {
        setState(() {
          manageResult = SnackType.success;
        });
        /*Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (Route<dynamic> route) => false,
        );*/
      } else {
        setState(() {
          manageResult = SnackType.error;
        });
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
                      child: AADropdownButton(
                        label: 'Grado de eduación',
                        options: options,
                        initialValue: selectUserType,
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
                        registerUser(context, UserRegisterModel(emailController.text, passwordController.text, confirmPasswordController.text, phoneController.text, fullNameController.text, selectUserType));
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
