import 'package:flutter/material.dart';
import 'package:augmented_anatomy/widgets/button.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.onRefresh,
    this.messageError
  });

  final VoidCallback onRefresh;
  final String? messageError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/error.png'),
          Text(
            'Ups! algo salió mal',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            messageError ?? 'Revisa tu conexión a internet e intenta nuevamente',
            textAlign: TextAlign.center,
          ),
          MainActionButton(
            text: 'Reintentar',
            onPressed: onRefresh,
          )
        ],
      ),
    );
    ;
  }
}
