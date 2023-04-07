import 'package:augmented_anatomy/models/characteristics.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SystemDetail extends StatefulWidget {
  SystemDetail({super.key});

  @override
  State<SystemDetail> createState() => _SystemDetailState();
}

class _SystemDetailState extends State<SystemDetail> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar:
            AAAppBar(context, back: true, title: 'Traer de widget anterior'),
        body: FutureBuilder(
            future: humanAnatomyService.getById(1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                snapshot.data!.image ?? '',
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              CharacteristicsSection(
                                characteristic1:
                                    snapshot.data!.characteristics![0],
                                characteristic2:
                                    snapshot.data!.characteristics![1],
                              )
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
                        ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return SingleChildScrollView(
                  child: Column(children: [Text(snapshot.error.toString())]),
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
            )
          ]),
    );
  }
}