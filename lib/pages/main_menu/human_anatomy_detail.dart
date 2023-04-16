import 'package:augmented_anatomy/models/characteristics.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../widgets/error.dart';

class SystemDetail extends StatefulWidget {
  SystemDetail({super.key});

  @override
  State<SystemDetail> createState() => _SystemDetailState();
}

class _SystemDetailState extends State<SystemDetail> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: args['name']),
        body: FutureBuilder(
            future: humanAnatomyService.getById(args['id']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: snapshot.data!.characteristics!.isNotEmpty ?
                            MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.image ?? '' ,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                ),
                              ),
                              snapshot.data!.characteristics!.isNotEmpty ? CharacteristicsSection(
                                characteristic1:
                                    snapshot.data!.characteristics![0],
                                characteristic2:
                                    snapshot.data!.characteristics![1],
                              ) : Container()
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Text(snapshot.data!.detail ?? '-'),
                          const SizedBox(height: 15.0),
                          Text(
                            'Articulos relacionados',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 15.0),
                          const ReferenceCard(
                            title: 'Internet',
                            subtitle: '8 archivos',
                            icon: Icons.more_vert,
                            iconBackgroundColor: AAColors.lightBlue,
                            iconColor: AAColors.blue,
                          ),
                          const ReferenceCard(
                            title: 'OMS',
                            subtitle: '8 archivos',
                            icon: Icons.more_vert,
                            iconBackgroundColor: AAColors.lightGreen,
                            iconColor: AAColors.green,
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
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        contentPadding: const EdgeInsets.all(20.0),
                                        content: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxHeight: 200,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Selecciona el sexo',
                                                style: Theme.of(context).textTheme.titleMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Seleccione el sexo del órgano a cargar en realidad aumentada.',
                                                style: Theme.of(context).textTheme.bodyLarge,
                                                textAlign: TextAlign.justify,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 125,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(context, '/ar-system');
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        primary: AAColors.lightGray,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        height: 80,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const Icon(Icons.male, size: 45, color: AAColors.black),
                                                            const SizedBox(height: 8),
                                                            Text(
                                                              'Masculino',
                                                              style: Theme.of(context).textTheme.labelMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16.0),
                                                  SizedBox(
                                                    width: 125,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(context, '/ar-system');
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        primary: AAColors.lightGray,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        height: 80,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const Icon(Icons.female, size: 45, color: AAColors.black),
                                                            const SizedBox(height: 8),
                                                            Text(
                                                              'Femenino',
                                                              style: Theme.of(context).textTheme.labelMedium,
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
                        ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ErrorMessage(
                              messageError: 'Ocurrio un error al momento de realizar la consulta',
                              onRefresh: (){
                                humanAnatomyService.getById(args['id']);
                              }
                          )
                        ]
                    ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
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
          color: AAColors.lightRed,
          title: characteristic2.title ?? '',
          detail: characteristic2.shortDetail ?? '',
        )
      ],
    );
  }
}

class CharacteristicCard extends StatelessWidget {
  const CharacteristicCard(
      {super.key,
      this.color = AAColors.lightGreen,
      required this.detail,
      required this.title});

  final Color color;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width * 0.40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.sticky_note_2_outlined,
              ),
              Text(
                title,
                textAlign: TextAlign.start,
                style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.2),
              ),
              Text(
                detail,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              )
            ]),
    );
  }
}
