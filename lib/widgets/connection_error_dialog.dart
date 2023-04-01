import 'package:flutter/material.dart';

class ConnectionErrorDialog extends StatelessWidget {
  const ConnectionErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Verifique su conexión a internet porfavor.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}