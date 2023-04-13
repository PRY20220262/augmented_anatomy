import 'package:augmented_anatomy/models/organs.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/human_anatomy_service.dart';
import '../../utils/connection_validator.dart';
import '../../widgets/button.dart';
import '../../widgets/error.dart';

class Organs extends StatefulWidget {
  const Organs({Key? key}) : super(key: key);

  @override
  State<Organs> createState() => _OrgansState();
}

class _OrgansState extends State<Organs> with SingleTickerProviderStateMixin, InternetConnectionMixin {

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
  List<String> organs = ["Respiratorio", "Digestivo", "Circulatorio", "Excretor"];
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
    if(hasConnection){
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
      }
      else {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  Future<void> filterOrgans({String? systemName = null, String? order = null}) async {
    try {
      organsList = await humanAnatomyService.getOrgans(systemName: systemName, order: order);
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
      }
      else {
        setState(() {
          errorMessage = e.toString();
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
      backgroundColor: AAColors.backgroundGrayView,
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
            child: !hasConnection ?
                //TODO: Manage connexion error
            Text(
                "No se ha encontrado una conexión a internet :(",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 2,
              )
                : isLoading ?
            const Center(
              child: SpinKitFadingCircle(
                color: AAColors.red,
                size: 50.0,
              ),
            ) : errorMessage != null ?
            ErrorMessage(onRefresh: checkConnectionDevice) :
            SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextField(
                        controller: searchController,
                        onTap: () => openKeyboard? _emptyNode.unfocus() : FocusScope.of(context).requestFocus(FocusNode()),
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
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  print(_selectedOrganIndex);
                                  return BuildBottomSheet(
                                    organs: organs,
                                    onSelectedIndexChanged: _onOrganSelected,
                                    selectedIndex: _selectedOrganIndex,
                                    options: options,
                                    initialValue: selectOptionFilter,
                                    selectedOption: (String? newValue) {
                                      selectOptionFilter = newValue!;
                                    },
                                    applyFilters: () {
                                      if (_selectedOrganIndex == -1) {
                                        filterOrgans(order: selectOptionFilter);
                                      } else {
                                        filterOrgans(order: selectOptionFilter, systemName: 'Sistema ${organs[_selectedOrganIndex]}');
                                      }
                                    }
                                    ,
                                  );
                                },
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(32)
                                  )
                                )
                            )
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
                )
            )
        )
    );
  }


}


class BuildBottomSheet extends StatefulWidget {
  const BuildBottomSheet({
    Key? key,
    required this.organs,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    required this.options,
    required this.initialValue,
    required this.selectedOption,
    required this.applyFilters

  }) : super(key: key);

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
          padding: const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          height: 8,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AAColors.red,
                            borderRadius: BorderRadius.circular(30),
                          )
                      ),
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
                                  // si se hace clic en el mismo elemento seleccionado,
                                  // deselecciona el elemento
                                  _selectedIndex = -1;
                                  widget.onSelectedIndexChanged(_selectedIndex);
                                } else {
                                  // de lo contrario, selecciona el nuevo elemento
                                  _selectedIndex = index;
                                  widget.onSelectedIndexChanged(index);
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? AAColors.blue : AAColors.lightGray,
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected ? AAColors.blue : AAColors.lightGray,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: isSelected ?  AAColors.blue : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected ? AAColors.blue : AAColors.lightGray,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.stethoscope,
                                        color: isSelected? AAColors.white : AAColors.black,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      widget.organs[index],
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: isSelected ? AAColors.blue : AAColors.grayLabel,
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
                    MainActionButton(
                        text: 'Aplicar',
                        width: MediaQuery.of(context).size.width * 1,
                        height: 50,
                        onPressed: (){
                          widget.applyFilters();
                          Navigator.of(context).pop();
                        }
                    )
                  ],
                )
            ),
        )
      ],
    );
  }
}
