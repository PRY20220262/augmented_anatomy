import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/augmented_anatomy_colors.dart';
import 'button.dart';

class LargeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String organsNumber;
  final String shortDetail;

  const LargeCard({super.key,
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 16,
                      color: AAColors.white
                  ),
                  softWrap: true,
                ),
                Text(
                  'Contiene $organsNumber organos',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AAColors.white
                  ),
                  softWrap: true,
                ),
                Text(
                  '$shortDetail',
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
    );
  }
}

Widget recommendationContainer(BuildContext context, String urlImage, String name, String shortDetail) {
  return Container(
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
                  urlImage,
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
                        name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        shortDetail,
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
  );
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
      width: MediaQuery.of(context).size.height * 0.27,
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
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
            ),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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

  const CardListItem({super.key,
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