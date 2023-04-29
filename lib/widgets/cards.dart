import 'package:augmented_anatomy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/augmented_anatomy_colors.dart';
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

Widget recommendationContainer(
    BuildContext context, String urlImage, String name, String shortDetail) {
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
                      onPressed: () {},
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
              borderRadius: BorderRadius.circular(20),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '$system',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '$shortDetail',
                  style: Theme.of(context).textTheme.bodyMedium,
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
              color: AAColors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.circular(15)),
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
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: AAColors.gray,
                  size: 30,
                ),
              ],
            ),
          )),
    );
  }
}

class NoteCard extends StatefulWidget {
  late int index;
  NoteCard({super.key, required this.index});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
                    offset: Offset(3, 3),
                  )
                ],
                color: cardColors[widget.index % 3],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'APunte de pulmones',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      PopupMenuButton<NoteMenuItem>(
                        // Callback that sets the selected popup menu item.
                        onSelected: (NoteMenuItem item) {},
                        constraints:
                            const BoxConstraints.expand(width: 60, height: 120),
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
                      'los pulmones de los hobres son mas grandes que el de las mujeres'),
                ),
              ]),
            ),
          )),
    );
  }
}
