import 'package:augmented_anatomy/models/note.dart';
import 'package:augmented_anatomy/services/note_service.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:flutter/material.dart';

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
