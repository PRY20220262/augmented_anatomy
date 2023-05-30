import 'package:augmented_anatomy/models/note.dart';
import 'package:augmented_anatomy/models/quiz_attempt_detail_grouped.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/widgets/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:augmented_anatomy/utils/string_extension.dart';
import 'package:augmented_anatomy/pages/quiz/quiz_attempt.dart';

import 'button.dart';

class LargeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String organsNumber;
  final String shortDetail;

  const LargeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.organsNumber,
    required this.shortDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.height * 0.19,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '$imageUrl',
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
                  '$name',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 16, color: AAColors.white),
                  softWrap: true,
                ),
                Text(
                  'Contiene $organsNumber organos',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AAColors.white),
                  softWrap: true,
                ),
                Text(
                  '$shortDetail',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AAColors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget recommendationContainer(BuildContext context, int humanAnatomyId,
    String urlImage, String name, String shortDetail) {
  return Container(
      height: 170,
      decoration: BoxDecoration(
        color: AAColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
        child: Row(
          children: [
            SizedBox(
              width: 125,
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    shortDetail,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  MainActionButton(
                      text: 'Probar ahora',
                      onPressed: () {
                        Navigator.pushNamed(context, '/detail',
                            arguments: {'id': humanAnatomyId, 'name': name});
                      },
                      width: MediaQuery.of(context).size.height * 0.35)
                ],
              ),
            ))
          ],
        ),
      ));
}

class DirectAccessCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const DirectAccessCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.19,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AAColors.black,
              size: 22,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 18),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(FontAwesomeIcons.arrowRight, color: AAColors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String system;
  final String shortDetail;

  const CardListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.system,
    required this.shortDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            height: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                '$imageUrl',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '$system',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$shortDetail',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReferenceCard extends StatelessWidget {
  const ReferenceCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.backgroundColor = Colors.white,
    this.settingsColor = Colors.grey,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color settingsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AAColors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 75,
                width: 75,
                child: Icon(
                  Icons.file_open,
                  color: iconColor,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              const Icon(
                Icons.more_vert_rounded,
                color: AAColors.black,
                size: 35,
              ),
            ],
          ),
        ));
  }
}

class NoteCard extends StatelessWidget {
  late int index;
  late Note note;
  late VoidCallback onDelete;
  final Function(String title, String content, int id) onUpdate;

  NoteCard(
      {super.key,
      required this.index,
      required this.note,
      required this.onDelete,
      required this.onUpdate});

  List<Color> cardColors = [
    AAColors.skyBlue2,
    AAColors.lightYellow,
    AAColors.lightGreen2
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(3, 3),
                  )
                ],
                color: cardColors[index % 3],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            note.title!,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          PopupMenuButton<NoteMenuItem>(
                            // Callback that sets the selected popup menu item.
                            onSelected: (NoteMenuItem item) {
                              if (item == NoteMenuItem.delete) {
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
                                          maxHeight: 160,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '¿Estás seguro que deseas eliminar el apunte?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  MainActionButton(
                                                      text: 'cancelar',
                                                      type:
                                                          ButtonType.secondary,
                                                      height: 40,
                                                      width: 110,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                  MainActionButton(
                                                      text: 'eliminar',
                                                      height: 40,
                                                      width: 110,
                                                      onPressed: onDelete)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditNote(
                                      note: note,
                                      onUpdate: onUpdate,
                                    );
                                  },
                                );
                              }
                            },
                            constraints: const BoxConstraints.expand(
                                width: 60, height: 120),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<NoteMenuItem>>[
                              const PopupMenuItem<NoteMenuItem>(
                                value: NoteMenuItem.edit,
                                child: Icon(Icons.edit),
                              ),
                              const PopupMenuItem<NoteMenuItem>(
                                value: NoteMenuItem.delete,
                                child: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        note.detail!,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}

class QuizAttemptCard extends StatelessWidget {
  late int index;
  late QuizAttemptDetailGrouped quizAttemptDetail;
  late VoidCallback onPress;

  QuizAttemptCard(
      {super.key,
      required this.index,
      required this.quizAttemptDetail,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                      content: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: quizAttemptDetail
                                    .quizAttemptByHumanAnatomy!.length *
                                70,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cuestionarios Realizados de ${quizAttemptDetail.nameHumanAnatomy}',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Fecha',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ))),
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.schedule_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Hora',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.quiz_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Nota',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      )))
                                ],
                              ),
                              SizedBox(
                                height: quizAttemptDetail
                                        .quizAttemptByHumanAnatomy!.length *
                                    30,
                                width: double.maxFinite,
                                child: ListView.builder(
                                  itemCount: quizAttemptDetail
                                      .quizAttemptByHumanAnatomy!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${quizAttemptDetail.quizAttemptByHumanAnatomy?[index].createdAt?.toFormattedDateString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                substractSixHoursFromDateTime(
                                                    quizAttemptDetail
                                                            .quizAttemptByHumanAnatomy![
                                                                index]
                                                            .createdAt ??
                                                        ''),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: Text(
                                              '${quizAttemptDetail.quizAttemptByHumanAnatomy![index].score! * 100 ~/ 20}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: (quizAttemptDetail
                                                                  .quizAttemptByHumanAnatomy![
                                                                      index]
                                                                  .score! <=
                                                              4.0)
                                                          ? AAColors.red
                                                          : (quizAttemptDetail
                                                                      .quizAttemptByHumanAnatomy![
                                                                          index]
                                                                      .score! <
                                                                  12.0)
                                                              ? AAColors.amber
                                                              : AAColors.green),
                                            )))
                                      ],
                                    );
                                  },
                                ),
                              ),
                              MainActionButton(
                                  text: 'Nuevo Intento',
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return InformationDialog(
                                            title: 'Nuevo Intento',
                                            message:
                                                'Estas apunto de iniciar un nuevo intento del cuestionario recien realizado.',
                                            cancelButtonText: 'Cancelar',
                                            onCancelPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            confirmButtonText: 'Nuevo Intento',
                                            onConfirmPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizAttempt(
                                                    id: quizAttemptDetail
                                                        .humanAnatomyId!,
                                                  ),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                          );
                                        });
                                  })
                            ],
                          )));
                });
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(3, 3),
              )
            ], color: AAColors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            quizAttemptDetail.nameHumanAnatomy!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AAColors.red),
                          ),
                          Text('${(quizAttemptDetail.maxScore! * 100) ~/ 20}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: (((quizAttemptDetail.maxScore! *
                                                      100) ~/
                                                  20) <=
                                              20)
                                          ? AAColors.red
                                          : (((quizAttemptDetail.maxScore! *
                                                          100) ~/
                                                      20) <
                                                  80.0)
                                              ? AAColors.amber
                                              : AAColors.green))
                        ]),
                    const SizedBox(height: 5),
                    Text(
                        'EL intento mas reciente realizado obtuvo ${quizAttemptDetail.maxScore! * 5 ~/ 20} respuestas correctas de las 5 preguntas realizadas.',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShortInfoQuiz(
                            icon: Icons.history,
                            text:
                                '${quizAttemptDetail.countAttempts} intentos realizados.'),
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                      ],
                    ),
                  ]),
            ),
          )),
    );
  }
}

class ShortInfoQuiz extends StatelessWidget {
  final IconData icon;
  final String text;
  final double sizeIcon;

  const ShortInfoQuiz(
      {required this.icon, required this.text, this.sizeIcon = 40.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.black,
        ),
        const SizedBox(width: 10),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class CharacteristicCard extends StatelessWidget {
  const CharacteristicCard(
      {super.key,
      required this.detail,
      required this.title,
      this.showIcon = true});

  final String title;
  final String detail;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: AAColors.lightMain, borderRadius: BorderRadius.circular(15)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showIcon
                ? const Icon(
                    Icons.sticky_note_2_outlined,
                    color: AAColors.mainColor,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.2,
                  color: AAColors.mainColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              detail,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AAColors.mainColor),
              maxLines: showIcon ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            )
          ]),
    );
  }
}
