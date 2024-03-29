import 'package:augmented_anatomy/pages/auth/login.dart';
import 'package:augmented_anatomy/pages/auth/register.dart';
import 'package:augmented_anatomy/pages/auth/request_pin.dart';
import 'package:augmented_anatomy/pages/auth/splash_screen.dart';
import 'package:augmented_anatomy/pages/auth/update_password.dart';
import 'package:augmented_anatomy/pages/auth/validate_pin.dart';
import 'package:augmented_anatomy/pages/main_menu/main_menu.dart';
import 'package:augmented_anatomy/pages/main_menu/human_anatomy_detail.dart';
import 'package:augmented_anatomy/pages/profile/change_password.dart';
import 'package:augmented_anatomy/pages/profile/notes.dart';
import 'package:augmented_anatomy/pages/profile/profile.dart';
import 'package:augmented_anatomy/pages/quiz/list_quiz_results.dart';
import 'package:augmented_anatomy/pages/quiz/quiz_attempt.dart';
import 'package:augmented_anatomy/pages/quiz/quiz_detail.dart';
import 'package:augmented_anatomy/utils/theme.dart';
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
        '/register': (context) => const Register(),
        '/forgot-password': (context) => RequestPin(),
        '/validate-pin': (context) => ValidatePin(),
        '/update-password': (context) => UpdatePassword(),
        '/change-password': (context) => ChangePassword(),
        '/home': (context) => const MainMenu(),
        '/notes': (context) => const Notes(),
        '/profile': (context) => Profile(),
        '/quiz-detail': (context) => const QuizDetail(),
        '/list-quiz-results': (context) => const ListQuizResults()
      },
    );
  }
}
