import 'package:augmented_anatomy/services/auth_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

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
  final _formKeyLogin = GlobalKey<FormState>();

  // Life Cycle

  // Functions

  Future<void> loginRequest(bool enableForm, BuildContext context) async {
    if (enableForm) {
      bool isLoggedIn = await authService.login(emailController.text, passwordController.text);
      setState(() {
        isLogin = isLoggedIn;
      });
      if (isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          isLogin = false;
        });
        showLoginSnackBar(context);
      }
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
              child: Form(
                key: _formKeyLogin,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.fill,
                      width: 270,
                      height: 48,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: InputLabel(
                          label: 'Correo',
                          hint: 'ejemplo@email.com',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: PasswordInputLabel(
                        label: 'Contraseña',
                        controller: passwordController,
                        hint: '*********',
                        isLogin: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                          child: NewTextActionButton(
                              text: '¿Olvidaste tu contraseña?',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              })
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: NewMainActionButton(
                        text: 'Ingresar',
                        onPressed: () {
                          bool validForm =
                          _formKeyLogin.currentState!.validate();
                          loginRequest(
                              validForm,
                              context
                          );
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
                            const SizedBox(width: 5),
                            NewTextActionButton(
                                text: 'Crear nueva cuenta',
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                })
                          ],
                        )),
                  ],
                ),
              )
            ),
          ),
        ));
  }
}
