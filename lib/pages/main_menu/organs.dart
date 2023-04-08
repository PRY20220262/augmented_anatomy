import 'package:augmented_anatomy/models/organs.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../services/human_anatomy_service.dart';

class Organs extends StatefulWidget {
  const Organs({Key? key}) : super(key: key);

  @override
  State<Organs> createState() => _OrgansState();
}

class _OrgansState extends State<Organs> {

  bool isLoadedOrgans = false;
  List<OrgansModel>? organsList;
  List<OrgansModel>? filteredList;
  TextEditingController searchController = TextEditingController();
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  void initState() {
    getOrgans();
    super.initState();
  }

  Future<void> getOrgans() async {
    try {
      organsList = await humanAnatomyService.getOrgans();
      setState(() {
        filteredList = organsList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AAColors.backgroundGrayView,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                  child: Text(
                    'Organos',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
              ),
            )
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  color: AAColors.backgroundGrayView,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) => {
                              setState(() {
                                filteredList = organsList?.where((organs) => organs.name.toLowerCase().contains(value.toLowerCase())).toList();
                              })
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
                              onPressed: () {
                              },
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                  Icons.filter_list,
                                  color: AAColors.grayBlue,
                                  size: 30),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.66,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: filteredList?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardListItem(
                                      imageUrl: '${filteredList?[index].imageUrl}',
                                      name: '${filteredList?[index].name}',
                                      system: '${filteredList?[index].system}',
                                      shortDetail: '${filteredList?[index].shortDetail}'
                                  );
                                }
                            ),
                          )
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}
