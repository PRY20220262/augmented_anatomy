import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';
import '../../utils/enums.dart';
import '../../widgets/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // Properties

  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;

  // Life Cycle

  // Functions

  Future<void> loginRequest(BuildContext context) async {
    bool isLoggedIn =
        await authService.login(emailController.text, passwordController.text);
    setState(() {
      isLogin = isLoggedIn;
    });
    if (isLoggedIn) {
      print("sesion inicada");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        isLogin = false;
      });
      print("credenciales erroneas");
      showLoginSnackBar(context);
    }
  }

  void showLoginSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      AASnackBar.buildSnack(
        context,
        'Credenciales incorrectas. Intente nuevamente',
        SnackType.warning,
      ),
    );
  }

  // User Interface

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AAColors.backgroundWhiteView,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      'Iniciar Sesión',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InputLabel(
                        label: 'Correo electrónico',
                        hint: 'example@email.com',
                        controller: emailController,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: PasswordInputLabel(
                      label: 'Contraseña',
                      hint: '*****************',
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextActionButton(
                              text: '¿Olvidaste tu contraseña?',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              })
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MainActionButton(
                      text: 'Ingresar',
                      onPressed: () {
                        loginRequest(context);
                      },
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '¿Aun no tienes cuenta?',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        TextActionButton(
                            text: 'Crear nueva cuenta',
                            onPressed: (){
                              Navigator.pushNamed(context, '/register');
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
