import 'package:augmented_anatomy/models/note.dart';
import 'package:augmented_anatomy/services/note_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:augmented_anatomy/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  NoteService noteService = NoteService();
  Future<List<Note>>? _notes;

  @override
  void initState() {
    super.initState();

    // initial load
    _notes = findNotes();
  }

  void _refresh() {
    // reload
    setState(() {
      _notes = findNotes();
    });
  }

  Future<bool> deleteNote(int id) async {
    print("RESPNSEE ALGO");
    // return the list here
    bool response = await noteService.deleteNote(id: id);
    _refresh();

    return response;
  }

  Future<List<Note>> findNotes() async {
    // return the list here
    return await noteService.findNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Mis apuntes'),
        body: FutureBuilder(
          future: _notes,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              late List<Note> notes = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteCard(
                        onDelete: () async {
                          await deleteNote(notes[index].id!);

                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                              AASnackBar.buildSnack(
                                  context,
                                  'Nota eliminada correctamente',
                                  SnackType.success));
                        },
                        index: index,
                        note: notes[index],
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return ErrorMessage(onRefresh: _refresh);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
