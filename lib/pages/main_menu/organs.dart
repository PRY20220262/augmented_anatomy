import 'package:augmented_anatomy/models/organs.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/connection_validator.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/error.dart';

import 'human_anatomy_detail.dart';

class Organs extends StatefulWidget {
  const Organs({Key? key}) : super(key: key);

  @override
  State<Organs> createState() => _OrgansState();
}

class _OrgansState extends State<Organs>
    with SingleTickerProviderStateMixin, InternetConnectionMixin {
  // Properties

  bool isLoading = false;
  bool hasConnection = true;
  bool hasInternet = true;
  String? errorMessage;
  int _selectedOrganIndex = -1;
  bool openKeyboard = true;
  List<OrgansModel>? organsList;
  List<OrgansModel>? filteredList;
  TextEditingController searchController = TextEditingController();
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();
  List<String> organs = [
    "Respiratorio",
    "Digestivo",
    "Circulatorio",
    "Excretor"
  ];
  final FocusNode _emptyNode = FocusNode();
  final options = {
    'No seleccionado': 'NOT_SELECTED',
    'Nombre ascendente': 'ASC',
    'Nombre descendente': 'DESC'
  };
  String selectOptionFilter = "NOT_SELECTED";

  @override
  void initState() {
    checkConnectionDevice();
    super.initState();
  }

  // Functions

  @override
  Future<void> checkConnectionDevice() async {
    isLoading = true;
    errorMessage = null;
    bool isConnected = await InternetValidator.validateConnectionDevice();
    setState(() {
      hasConnection = isConnected;
    });
    if (hasConnection) {
      getOrgans();
    } else {
      print("NO HAY CONEXION A INTERNET");
      setState(() {
        isLoading = false;
        hasConnection = false;
      });
    }
  }

  Future<void> getOrgans() async {
    try {
      organsList = await humanAnatomyService.getOrgans();
      setState(() {
        filteredList = organsList;
        hasInternet = true;
        isLoading = false;
      });
    } catch (e) {
      if (e.toString() == 'La solicitud ha excedido el tiempo de espera') {
        hasConnection = false;
        isLoading = false;
        errorMessage = e.toString();
      } else {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  Future<void> filterOrgans({
    String? systemName = null,
    String? order = null}) async {
    try {
      organsList = await humanAnatomyService.getOrgans(
          systemName: systemName, order: order);
      setState(() {
        errorMessage = null;
        filteredList = organsList;
        hasInternet = true;
        isLoading = false;
      });
    } catch (e) {
      if (e.toString() == 'La solicitud ha excedido el tiempo de espera') {
        hasConnection = false;
        isLoading = false;
        errorMessage = e.toString();
      } else {
        setState(() {
          errorMessage = "EMPTY_LIST";
          isLoading = false;
        });
      }
    }
  }

  void _onOrganSelected(int index) {
    setState(() {
      _selectedOrganIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AAColors.backgroundWhiteView,
        appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.width * 0.20),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.08),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'Órganos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )),
        body: SafeArea(
            child: !hasConnection
                ?
                Text(
                    "No se ha encontrado una conexión a internet :(",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                  )
                : isLoading
                    ? const Center(
                        child: SpinKitFadingCircle(
                          color: AAColors.red,
                          size: 50.0,
                        ),
                      )
                    : errorMessage != null && errorMessage != "EMPTY_LIST" ?
                      ErrorMessage(onRefresh: checkConnectionDevice) :
                      SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.02),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height * 0.09,
                                    width: MediaQuery.of(context).size.width - 40,
                                    child: TextField(
                                      controller: searchController,
                                      onTap: () => openKeyboard
                                          ? _emptyNode.unfocus()
                                          : FocusScope.of(context)
                                          .requestFocus(FocusNode()),
                                      onChanged: (value) => {
                                        setState(() {
                                          filteredList = organsList
                                              ?.where((organs) => organs.name
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                              .toList();
                                          if (filteredList!.isEmpty){
                                            setState(() {
                                              errorMessage = "EMPTY_LIST";
                                            });
                                            print(filteredList);
                                          } else {
                                            setState(() {
                                              errorMessage = null;
                                            });
                                          }
                                        })
                                      },
                                      style:
                                      Theme.of(context).textTheme.labelMedium,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        hintText: 'Buscar',
                                        hintStyle:
                                        const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:
                                          const BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:
                                          const BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:
                                          const BorderSide(color: Colors.grey),
                                        ),
                                        suffixIcon: IconButton(
                                            icon: const Icon(Icons.filter_list,
                                                color: Colors.grey, size: 30),
                                            onPressed: () => showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  print(_selectedOrganIndex);
                                                  return BuildBottomSheet(
                                                    organs: organs,
                                                    onSelectedIndexChanged:
                                                    _onOrganSelected,
                                                    selectedIndex:
                                                    _selectedOrganIndex,
                                                    options: options,
                                                    initialValue:
                                                    selectOptionFilter,
                                                    selectedOption:
                                                        (String? newValue) {
                                                      selectOptionFilter =
                                                      newValue!;
                                                    },
                                                    applyFilters: () {
                                                      if (_selectedOrganIndex ==
                                                          -1) {
                                                        filterOrgans(
                                                            order:
                                                            selectOptionFilter);
                                                      } else {
                                                        filterOrgans(
                                                            order:
                                                            selectOptionFilter,
                                                            systemName:
                                                            'Sistema ${organs[_selectedOrganIndex]}');
                                                      }
                                                    },
                                                  );
                                                },
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            32))))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * 0.66,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: (errorMessage == "EMPTY_LIST") && filteredList!.length >= 0 ?
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height,
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                EmptyElementError(
                                                  title: 'No se encontraron órganos',
                                                  messageError:
                                                  'Por el momento no encontramos órganos con los filtros seleccionados.',
                                                )
                                              ]),
                                        ) : ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: filteredList?.length ?? 0,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => SystemDetail(
                                                        id: filteredList![index].id,
                                                        name: filteredList![index].name,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: CardListItem(
                                                    imageUrl:
                                                    '${filteredList?[index].imageUrl}',
                                                    name:
                                                    '${filteredList?[index].name}',
                                                    system:
                                                    '${filteredList?[index].system}',
                                                    shortDetail:
                                                    '${filteredList?[index].shortDetail}'),
                                              );
                                            }),
                                      )),
                                ],
                              )
                            )
                      )
        ));
  }
}

class BuildBottomSheet extends StatefulWidget {
  const BuildBottomSheet(
      {Key? key,
      required this.organs,
      required this.selectedIndex,
      required this.onSelectedIndexChanged,
      required this.options,
      required this.initialValue,
      required this.selectedOption,
      required this.applyFilters})
      : super(key: key);

  final List<String> organs;
  final int selectedIndex;
  final Function(int) onSelectedIndexChanged;
  final Map<String, String> options;
  final String initialValue;
  final OnChangedCallback? selectedOption;
  final Function applyFilters;

  @override
  State<BuildBottomSheet> createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {
  int _selectedIndex = 0;
  late String _dropdownValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    height: 8,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AAColors.mainColor,
                      borderRadius: BorderRadius.circular(4),
                    )),
              ),
              const SizedBox(height: 20),
              Text(
                'Filtro por sistema',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 115,
                child: ListView.builder(
                  itemCount: widget.organs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedIndex == index) {
                            _selectedIndex = -1;
                            widget.onSelectedIndexChanged(_selectedIndex);
                          } else {
                            _selectedIndex = index;
                            widget.onSelectedIndexChanged(index);
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AAColors.textActionColor
                                  : AAColors.lightGray,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 65,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AAColors.textActionColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? AAColors.textActionColor
                                        : AAColors.lightGray,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.stethoscope,
                                  color: isSelected
                                      ? AAColors.white
                                      : AAColors.black,
                                  size: 25,
                                ),
                              ),
                              Text(
                                widget.organs[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: isSelected
                                          ? AAColors.textActionColor
                                          : AAColors.grayLabel,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ordenar por',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              AADropdownButton(
                options: widget.options,
                initialValue: _dropdownValue,
                width: 1,
                selectedOption: (String? newValue) {
                  widget.selectedOption!(newValue);
                },
              ),
              const SizedBox(height: 13),
              NewMainActionButton(
                  text: 'Aplicar',
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    widget.applyFilters();
                    Navigator.of(context).pop();
                  })
            ],
          )),
        )
      ],
    );
  }
}
