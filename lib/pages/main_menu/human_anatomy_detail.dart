import 'package:augmented_anatomy/models/characteristics.dart';
import 'package:augmented_anatomy/pages/ar/ar_view.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/anatomy_reference.dart';
import '../../utils/string_extension.dart';

class SystemDetail extends StatefulWidget {
  SystemDetail({super.key});

  @override
  State<SystemDetail> createState() => _SystemDetailState();
}

class _SystemDetailState extends State<SystemDetail> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();
  List<AnatomyReference>? anatomyReferences;
  List<AnatomyReference>? anatomyReferenceOMSList;
  List<AnatomyReference>? anatomyReferenceINTERNETList;
  Future<void>? _launched;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReferences();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> getReferences() async {
    try {
      final referencesMap = await humanAnatomyService.getAnatomyReferences(1);
      setState(() {
        anatomyReferenceOMSList = referencesMap['OMS'] ?? [];
        anatomyReferenceINTERNETList = referencesMap['INTERNET'] ?? [];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: AAColors.backgroundWhiteView,
      appBar: AAAppBar(context, back: true, title: args['name']),
      body: SafeArea(
        child: FutureBuilder(
            future: humanAnatomyService.getById(args['id']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                snapshot.data!.characteristics!.isNotEmpty
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data!.image ?? '',
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: snapshot
                                            .data!.characteristics!.isNotEmpty
                                        ? MediaQuery.of(context).size.width *
                                            0.45
                                        : MediaQuery.of(context).size.width *
                                            0.9,
                                  )),
                              snapshot.data!.characteristics!.isNotEmpty
                                  ? CharacteristicsSection(
                                      characteristic1:
                                          snapshot.data!.characteristics![0],
                                      characteristic2:
                                          snapshot.data!.characteristics![1],
                                    )
                                  : Container()
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Text(snapshot.data!.detail ?? '-',
                              textAlign: TextAlign.justify),
                          const SizedBox(height: 15.0),
                          Text(
                            'Artículos relacionados',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                        content: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxHeight: 350),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Referencias de Internet',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 15.0),
                                                Text(
                                                    'Las referencias usadas para la informacion mostrada es de las siguietnes fuentes: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                                const SizedBox(height: 15.0),
                                                SizedBox(
                                                  height: 240,
                                                  width: double.maxFinite,
                                                  child: ListView.builder(
                                                    itemCount:
                                                        anatomyReferenceINTERNETList
                                                            ?.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AAColors
                                                                .lightBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                        anatomyReferenceINTERNETList?[index].title ??
                                                                            '',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium)),
                                                                const SizedBox(
                                                                    width:
                                                                        15.0),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text: getDisplayText(
                                                                          anatomyReferenceINTERNETList?[index]
                                                                              .url),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium
                                                                          ?.copyWith(
                                                                              color: AAColors.blue),
                                                                      recognizer:
                                                                          TapGestureRecognizer()
                                                                            ..onTap = () =>
                                                                                setState(() {
                                                                                  _launched = _launchInBrowser(Uri.parse(anatomyReferenceINTERNETList?[index].url ?? ''));
                                                                                }),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )));
                                  });
                            },
                            child: const ReferenceCard(
                              title: 'Internet',
                              subtitle: '8 archivos',
                              icon: Icons.more_vert,
                              iconBackgroundColor: AAColors.lightBlue,
                              iconColor: AAColors.blue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                        content: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxHeight: 350),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Referencias de OMS',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 15.0),
                                                Text(
                                                    'Las referencias usadas para la informacion mostrada es de las siguietnes fuentes: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                                const SizedBox(height: 15.0),
                                                SizedBox(
                                                  height: 240,
                                                  width: double.maxFinite,
                                                  child: ListView.builder(
                                                    itemCount:
                                                        anatomyReferenceOMSList
                                                            ?.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AAColors
                                                                .lightGreen,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                        anatomyReferenceOMSList?[index].title ??
                                                                            '',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium)),
                                                                const SizedBox(
                                                                    width:
                                                                        15.0),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text: getDisplayText(
                                                                          anatomyReferenceOMSList?[index]
                                                                              .url),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium
                                                                          ?.copyWith(
                                                                              color: AAColors.blue),
                                                                      recognizer:
                                                                          TapGestureRecognizer()
                                                                            ..onTap = () =>
                                                                                setState(() {
                                                                                  _launched = _launchInBrowser(Uri.parse(anatomyReferenceOMSList?[index].url ?? ''));
                                                                                }),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )));
                                  });
                            },
                            child: const ReferenceCard(
                              title: 'OMS',
                              subtitle: '8 archivos',
                              icon: Icons.more_vert,
                              iconBackgroundColor: AAColors.lightGreen,
                              iconColor: AAColors.green,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Center(
                            child: MainActionButton(
                                text: 'Visualizar en RA',
                                width: 170,
                                height: 40,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        contentPadding: EdgeInsets.all(20.0),
                                        content: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: 200,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sexo de organo',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Seleccione el sexo del órgano a cargar en realidad aumentada.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                                textAlign: TextAlign.justify,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 125,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ArHumanAnatomy(
                                                                          id: snapshot
                                                                              .data!
                                                                              .id!,
                                                                          name: snapshot
                                                                              .data!
                                                                              .name!,
                                                                          characteristics: snapshot
                                                                              .data!
                                                                              .characteristics,
                                                                        )));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            AAColors.lightGray,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        height: 80,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.male,
                                                                size: 45,
                                                                color: AAColors
                                                                    .black),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              'Masculino',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16.0),
                                                  Container(
                                                    width: 125,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ArHumanAnatomy(
                                                                          id: snapshot
                                                                              .data!
                                                                              .id!,
                                                                          name: snapshot
                                                                              .data!
                                                                              .name!,
                                                                          characteristics: snapshot
                                                                              .data!
                                                                              .characteristics,
                                                                        )));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            AAColors.lightGray,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        height: 80,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.female,
                                                                size: 45,
                                                                color: AAColors
                                                                    .black),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              'Femenino',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                          const SizedBox(height: 15.0),
                          FutureBuilder<void>(
                              future: _launched, builder: _launchStatus),
                        ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ErrorMessage(
                            messageError:
                                'Ocurrio un error al momento de realizar la consulta',
                            onRefresh: () {
                              humanAnatomyService.getById(args['id']);
                            })
                      ]),
                );
              } else {
                return const Center(
                  child: SpinKitFadingCircle(
                    color: AAColors.red,
                    size: 50.0,
                  ),
                );
              }
            }),
      ),
    );
  }
}

class CharacteristicsSection extends StatelessWidget {
  const CharacteristicsSection(
      {super.key,
      required this.characteristic1,
      required this.characteristic2});

  final Characteristic characteristic1;
  final Characteristic characteristic2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CharacteristicCard(
          title: characteristic1.title ?? '',
          detail: characteristic1.shortDetail ?? '',
        ),
        const SizedBox(height: 10),
        CharacteristicCard(
          title: characteristic2.title ?? '',
          detail: characteristic2.shortDetail ?? '',
        )
      ],
    );
  }
}
