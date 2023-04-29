import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  void _refresh() {
    // reload
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Mis apuntes'),
        body: FutureBuilder(
          future: _calculation,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  return NoteCard(
                    index: index,
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
