import 'package:augmented_anatomy/models/main_menu.dart';
import 'package:augmented_anatomy/pages/home/main_menu.dart';
import 'package:augmented_anatomy/services/home_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Properites

  late final mainMenu = const MainMenu();
  HomeService homeService = HomeService();

  // Life Cycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.width * 0.20),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/largeIcon.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.25,
                  )
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AAColors.pink, // Color del botón
                    ),
                    child: InkWell(
                      onTap: () {
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(FontAwesomeIcons.user, color: AAColors.black), // Icono del botón
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
        body: SafeArea(
          child: FutureBuilder<MainMenuModel>(
            future: homeService.getMainMenu(),
            builder: (context, snapshot)  {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitFadingCircle(
                  color: AAColors.red,
                  size: 50.0,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                      child: Column(
                        children: [
                           SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Actividad reciente',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.width * 0.03,
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data?.recentActivityList.length,
                                          itemBuilder: (context, index) => Container(
                                              decoration: BoxDecoration(
                                                color: index % 2 != 0 ? AAColors.darkRed : AAColors.skyBlue,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.19,
                                              width: MediaQuery.of(context).size.width * 0.6,
                                              margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.03),
                                              child: Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.22,
                                                      height: MediaQuery.of(context).size.height * 0.19,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Image.network(
                                                          '${snapshot.data?.recentActivityList[index].urlImage}',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.03,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${snapshot.data?.recentActivityList[index].name}',
                                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                                fontSize: 16,
                                                                color: AAColors.white
                                                            ),
                                                            softWrap: true,
                                                          ),
                                                          Text(
                                                            'Contiene ${snapshot.data?.recentActivityList[index].organsNumber} organos',
                                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                                color: AAColors.white
                                                            ),
                                                            softWrap: true,
                                                          ),
                                                          Text(
                                                            '${snapshot.data?.recentActivityList[index].shortDetail}',
                                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                                color: AAColors.white
                                                            ),
                                                            softWrap: true,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          )
                                      ),
                                    )
                                  ],
                                ),
                           ),
                          const SizedBox( height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recomendaciones del día',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox( height: 10),
                              Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: AAColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 125,
                                          height: 130,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              '${snapshot.data?.recommendation.urlImage}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data?.recommendation.name}',
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                  ),
                                                  Text(
                                                    '${snapshot.data?.recommendation.shortDetail}',
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                  MainActionButton(text: 'Probar ahora', onPressed: (){}, width: MediaQuery.of(context).size.height * 0.35)
                                                ],
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                          const SizedBox( height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accesos directos',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox( height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.height * 0.27,
                                      height: MediaQuery.of(context).size.height * 0.19,
                                      decoration: BoxDecoration(
                                        color: AAColors.lightBlue,
                                        borderRadius: BorderRadius.circular(20), // Radio de los bordes
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.file,
                                              color: AAColors.black,
                                              size: 22,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              'Mis apuntes',
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                  fontSize: 18
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data?.quizCount} apuntes',
                                                style: Theme.of(context).textTheme.bodyMedium
                                            ),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Icon(FontAwesomeIcons.arrowRight, color: AAColors.black),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.height * 0.27,
                                      height: MediaQuery.of(context).size.height * 0.19,
                                      decoration: BoxDecoration(
                                        color: AAColors.lightRed,
                                        borderRadius: BorderRadius.circular(20), // Radio de los bordes
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.assignment_turned_in_outlined,
                                              color: AAColors.black,
                                              size: 25,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              'Mis cuestionarios',
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                  fontSize: 18
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data?.noteCount} apuntes',
                                                style: Theme.of(context).textTheme.bodyMedium
                                            ),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Icon(FontAwesomeIcons.arrowRight, color: AAColors.black),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox( height: 70),
                        ],
                      )
                  )
                );
              }
            },
          )
        )
    );
  }
}

// Text('Data: ${snapshot.data}');
/*ListView.builder(
scrollDirection: Axis.horizontal,
shrinkWrap: true, // Permite que el contenedor abarque el tamaño total de la lista
itemCount: snapshot.data?.recentActivityList.length,
itemBuilder: (context, index) {
final activity = snapshot.data?.recentActivityList[index];
return Card(
child: ListTile(
title: Text('${activity?.name}'),
subtitle: Text('${activity?.shortDetail}'),
),
);
},
),*/
