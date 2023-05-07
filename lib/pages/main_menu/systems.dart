import 'package:augmented_anatomy/models/system_list.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      backgroundColor: AAColors.backgroundGrayView,
      body: FutureBuilder(
          future: _systems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                SearchBar(
                  searchController: searchController,
                  searchFilter: searchFilter,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final systems = snapshot.data!;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail', arguments: {
                              'id': systems[index].id,
                              'name': systems[index].name
                            });
                          },
                          child: CardListItem(
                              imageUrl: '${systems[index].image}',
                              name: '${systems[index].name}',
                              system: '${systems[index].organsNumber} órganos',
                              shortDetail: '${systems[index].shortDetail}'),
                        );
                      }),
                )
              ]);
            } else if (snapshot.hasError) {
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
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          searchFilter(value);
        },
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: AAColors.blueInput,
          hintText: 'Buscar organo',
          hintStyle: const TextStyle(color: AAColors.grayBlue),
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: AAColors.grayBlue,
              size: 30,
            ),
            onPressed: () {},
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
