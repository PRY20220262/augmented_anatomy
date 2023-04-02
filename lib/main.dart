import 'package:augmented_anatomy/pages/auth/login.dart';
import 'package:augmented_anatomy/pages/auth/request_pin.dart';
import 'package:augmented_anatomy/pages/auth/splash_screen.dart';
import 'package:augmented_anatomy/utils/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AugmentedAnatomy());
}

class AugmentedAnatomy extends StatelessWidget {
  const AugmentedAnatomy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito Sans',
        textTheme: getAATextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/forgot-password': (context) => RequestPin()
      },
    );
  }
}
