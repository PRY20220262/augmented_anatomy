import 'package:augmented_anatomy/models/system_list.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'human_anatomy_detail.dart';

class Systems extends StatefulWidget {
  const Systems({Key? key}) : super(key: key);

  @override
  State<Systems> createState() => _SystemsState();
}

class _SystemsState extends State<Systems> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();
  Future<List<SystemList>>? _systems;

  TextEditingController searchController = TextEditingController();

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

  void searchFilter(String name) {
    setState(() {
      _systems = searchSystem(name);
    });
  }

  Future<List<SystemList>> findSystems() async {
    // return the list here
    return await humanAnatomyService.findSystems();
  }

  Future<List<SystemList>> searchSystem(String name) async {
    // return the list here
    return await humanAnatomyService.searchSystem(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAAppBar(context, back: false, title: 'Sistemas'),
      backgroundColor: AAColors.backgroundWhiteView,
      body: FutureBuilder(
          future: _systems,
          builder: (context, snapshot) {
            if (snapshot.hasData ||
                snapshot.error.toString() == "No se han encontrado datos :(") {
              return Column(children: [
                SearchBar(
                  searchController: searchController,
                  searchFilter: searchFilter,
                ),
                const SizedBox(height: 10),
                (snapshot.error.toString() == "No se han encontrado datos :(")
                    ? Container(
                        child: SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EmptyElementError(
                                  title: 'No se encontraron órganos',
                                  messageError:
                                      'Por el momento no encontramos órganos con los filtros seleccionados.',
                                )
                              ]),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final systems = snapshot.data!;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SystemDetail(
                                          id: systems[index].id ?? 0,
                                          name: systems[index].name ?? ''),
                                    ),
                                  );
                                },
                                child: CardListItem(
                                    imageUrl: '${systems[index].image}',
                                    name: '${systems[index].name}',
                                    system:
                                        '${systems[index].organsNumber} órganos',
                                    shortDetail:
                                        '${systems[index].shortDetail}'),
                              );
                            }),
                      )
              ]);
            } else if (snapshot.hasError &&
                snapshot.error.toString() != "No se han encontrado datos :(") {
              return ErrorMessage(onRefresh: refresh);
            } else {
              return const Center(
                child: SpinKitFadingCircle(
                  color: AAColors.red,
                  size: 50.0,
                ),
              );
            }
          }),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) searchFilter;

  const SearchBar({
    Key? key,
    required this.searchController,
    required this.searchFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width - 40,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          searchFilter(value);
        },
        style: Theme.of(context).textTheme.labelMedium,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Buscar',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {},
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey),
            )),
      ),
    );
  }
}
