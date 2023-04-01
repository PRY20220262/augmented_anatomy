import 'package:augmented_anatomy/widgets/input.dart';
import 'package:flutter/material.dart';

class RequestPin extends StatelessWidget {
  const RequestPin({super.key});

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
          const SizedBox(
            height: 30.0,
          ),
          const InputLabel(
            label: 'Correo electrónico',
            hint: 'example@email.com',
          ),
        ]),
      ),
    );
  }
}
