import 'package:augmented_anatomy/models/system_list.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/material.dart';

class Systems extends StatefulWidget {
  const Systems({Key? key}) : super(key: key);

  @override
  State<Systems> createState() => _SystemsState();
}

class _SystemsState extends State<Systems> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();
  Future<List<SystemList>>? _systems;

  @override
  void initState() {
    super.initState();

    // initial load
    _systems = findSystems();
  }

  void refresh() {
    // reload
    setState(() {
      _systems = findSystems();
    });
  }

  Future<List<SystemList>> findSystems() async {
    // return the list here
    return await humanAnatomyService.findSystems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAAppBar(context, back: false, title: 'Sistemas'),
      backgroundColor: AAColors.backgroundGrayView,
      body: FutureBuilder(
          future: _systems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(snapshot.data![index].name ?? 'hola'),
                        MainActionButton(
                          text: 'Reintentar',
                          onPressed: refresh,
                        )
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return ErrorMessage(onRefresh: refresh);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
