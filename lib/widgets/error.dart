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

class EmptyElementError extends StatelessWidget {
  const EmptyElementError({
    super.key,
    this.title,
    this.messageError
  });

  final String? title;
  final String? messageError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error_empty_list.png',
            height: 250,
            width: 250,
            fit: BoxFit.fill,
          ),
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Text(
            messageError ?? '',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    ;
  }
}

