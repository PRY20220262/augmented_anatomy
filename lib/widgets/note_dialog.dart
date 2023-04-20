import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:flutter/material.dart';

class NoteDialog extends StatelessWidget {
  NoteDialog({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Crear apunte',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15.0),
            InputLabel(
              controller: titleController,
              label: 'Titulo',
            ),
            const SizedBox(height: 20.0),
            DescriptionInput(
              controller: descriptionController,
              label: 'Descripción',
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainActionButton(
                      text: 'cancelar',
                      type: ButtonType.secondary,
                      height: 40,
                      width: 110,
                      onPressed: () {}),
                  MainActionButton(
                      text: 'guardar', height: 40, width: 110, onPressed: () {})
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
