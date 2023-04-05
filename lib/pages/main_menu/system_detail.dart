import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SystemDetail extends StatelessWidget {
  SystemDetail({super.key});

  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Corazón'),
        body: FutureBuilder(
            future: humanAnatomyService.getById(1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return SingleChildScrollView(
                  child: Column(children: [Text('a')]),
                );
              } else if (snapshot.hasError) {
                return SingleChildScrollView(
                  child: Column(children: [Text(snapshot.error.toString())]),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
