import 'package:augmented_anatomy/models/note.dart';
import 'package:augmented_anatomy/services/note_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/augmented_anatomy_colors.dart';

class NoteDialog extends StatelessWidget {
  NoteDialog({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  NoteService noteService = NoteService();

  Future<void> createNote(BuildContext context) async {
    bool successRequest = await noteService.createNote(
        title: titleController.text, description: descriptionController.text);

    Navigator.of(context).pop();
    if (successRequest) {
      ScaffoldMessenger.of(context).showSnackBar(AASnackBar.buildSnack(
          context, 'Nota creada correctamente.', SnackType.success));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(AASnackBar.buildSnack(
          context,
          'Ha ocurrido un error, intente nuevamente luego.',
          SnackType.warning));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
                    text: 'Cance;ar',
                    type: ButtonType.secondary,
                    height: 40,
                    width: 110,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                NewMainActionButton(
                    text: 'Guardar',
                    border: 4,
                    height: 40,
                    width: 110,
                    onPressed: () {
                      createNote(context);
                    })
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class EditNote extends StatefulWidget {
  Note note;
  final Function(String title, String content, int id) onUpdate;
  EditNote({super.key, required this.note, required this.onUpdate});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  NoteService noteService = NoteService();

  void _onUpdate() {
    widget.onUpdate(
        titleController.text, descriptionController.text, widget.note.id!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.note.title!;
    descriptionController.text = widget.note.detail!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            'Editar apunte',
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                MainActionButton(
                    text: 'guardar',
                    height: 40,
                    width: 110,
                    onPressed: _onUpdate)
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class InformationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelButtonText;
  final String confirmButtonText;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;

  const InformationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainActionButton(
                    text: cancelButtonText,
                    type: ButtonType.secondary,
                    height: 40,
                    width: 135,
                    onPressed: onCancelPressed),
                NewMainActionButton(
                    text: confirmButtonText,
                    border: 4.0,
                    height: 40,
                    width: 135,
                    onPressed: onConfirmPressed),
              ],
            )
          ],
        ),
      ),
    );
  }
}
