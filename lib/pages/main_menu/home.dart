import 'package:augmented_anatomy/models/main_menu.dart';
import 'package:augmented_anatomy/pages/main_menu/main_menu.dart';
import 'package:augmented_anatomy/services/home_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
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
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.width * 0.20),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05),
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
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AAColors.pink, // Color del botón
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/profile');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(FontAwesomeIcons.user,
                              color: AAColors.black), // Icono del botón
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        body: SafeArea(
            child: FutureBuilder<MainMenuModel>(
          future: homeService.getMainMenu(),
          builder: (context, snapshot) {
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
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02),
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
                                  height:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data?.recentActivityList?.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                              decoration: BoxDecoration(
                                                color: index % 2 != 0
                                                    ? AAColors.darkRed
                                                    : AAColors.skyBlue,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.19,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03),
                                              child: LargeCard(
                                                imageUrl:
                                                    '${snapshot.data!.recentActivityList?[index].urlImage}',
                                                name:
                                                    '${snapshot.data!.recentActivityList?[index].name}',
                                                organsNumber:
                                                    '${snapshot.data!.recentActivityList?[index].organsNumber}',
                                                shortDetail:
                                                    '${snapshot.data!.recentActivityList?[index].shortDetail}',
                                              ))),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recomendaciones del día',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 10),
                              recommendationContainer(
                                  context,
                                  '${snapshot.data?.recommendation?.urlImage}',
                                  '${snapshot.data?.recommendation?.name}',
                                  '${snapshot.data?.recommendation?.shortDetail}')
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accesos directos',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DirectAccessCard(
                                      icon: FontAwesomeIcons.file,
                                      color: AAColors.lightBlue,
                                      title: 'Mis apuntes',
                                      subtitle:
                                          '${snapshot.data?.quizCount} apuntes'),
                                  DirectAccessCard(
                                      icon: Icons.assignment_turned_in_outlined,
                                      color: AAColors.lightRed,
                                      title: 'Mis cuestionarios',
                                      subtitle:
                                          '${snapshot.data?.noteCount} cuestionarios')
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 70),
                        ],
                      )));
            }
          },
        )));
  }
}
