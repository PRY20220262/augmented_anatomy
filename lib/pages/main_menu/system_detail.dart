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
                              CharacteristicsSection()
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
  const CharacteristicsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CharacteristicCard(),
        const SizedBox(height: 10),
        CharacteristicCard(color: AAColors.lightRed)
      ],
    );
  }
}

class CharacteristicCard extends StatelessWidget {
  const CharacteristicCard({super.key, this.color = AAColors.lightGreen});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width * 0.40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Cantidad de organos',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '6 organos',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ]),
    );
  }
}
