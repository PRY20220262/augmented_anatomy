import 'package:augmented_anatomy/models/main_menu.dart';
import 'package:augmented_anatomy/pages/main_menu/main_menu.dart';
import 'package:augmented_anatomy/services/home_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/note_dialog.dart';
import 'human_anatomy_detail.dart';

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
                  'Inicio',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AAColors.lightMain, // Color del botón
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/profile');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(FontAwesomeIcons.user,
                              color: AAColors.mainColor), // Icono del botón
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
                  child: Container(
                      color: AAColors.backgroundWhiteView,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 125,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot
                                              .data?.recentActivityList?.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      color:
                                                          AAColors.borderGray,
                                                    ),
                                                  ),
                                                  height: 125,
                                                  width: 275,
                                                  margin: EdgeInsets.only(
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SystemDetail(
                                                            id: snapshot
                                                                    .data!
                                                                    .recentActivityList![
                                                                        index]
                                                                    .humanAnatomyId ??
                                                                0,
                                                            name: snapshot
                                                                    .data!
                                                                    .recentActivityList![
                                                                        index]
                                                                    .name ??
                                                                '',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: LargeCard(
                                                      imageUrl:
                                                          '${snapshot.data!.recentActivityList?[index].urlImage}',
                                                      name:
                                                          '${snapshot.data!.recentActivityList?[index].name}',
                                                      organsNumber:
                                                          '${snapshot.data!.recentActivityList?[index].organsNumber}',
                                                      shortDetail:
                                                          '${snapshot.data!.recentActivityList?[index].shortDetail}',
                                                    ),
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  recommendationContainer(
                                      context,
                                      snapshot.data?.recommendation!
                                              .humanAnatomyId ??
                                          0,
                                      '${snapshot.data?.recommendation?.urlImage}',
                                      '${snapshot.data?.recommendation?.name}',
                                      '${snapshot.data?.recommendation?.shortDetail}')
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Accesos directos',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/notes');
                                    },
                                    child: DirectAccessCard(
                                      icon: Icons.note_outlined,
                                      iconColor: AAColors.mainColor,
                                      containerColor: AAColors.lightMain,
                                      title: 'Mis apuntes',
                                      subtitle: snapshot.data?.noteCount == 1
                                          ? '${snapshot.data?.noteCount} apunte'
                                          : '${snapshot.data?.noteCount} apuntes',
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/list-quiz-results');
                                      },
                                      child: DirectAccessCard(
                                        icon: Icons.question_mark_sharp,
                                        iconColor: AAColors.textOrange,
                                        containerColor: AAColors.lightOrange,
                                        title: 'Mis cuestionarios',
                                        subtitle: snapshot.data?.quizCount == 1
                                            ? '${snapshot.data?.quizCount} cuestionario'
                                            : '${snapshot.data?.quizCount} cuestionarios',
                                      ))
                                ],
                              ),
                            ],
                          ))));
            }
          },
        )));
  }
}
