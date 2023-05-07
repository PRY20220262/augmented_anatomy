import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/human_anatomy_service.dart';
import '../../utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/error.dart';

class QuizDetail extends StatefulWidget {
  const QuizDetail({Key? key}) : super(key: key);

  @override
  State<QuizDetail> createState() => _QuizDetailState();
}

class _QuizDetailState extends State<QuizDetail> {
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Cuestionario'),
        body: SafeArea(
            child: FutureBuilder(
                future: humanAnatomyService.getById(3),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      snapshot.data!.image ?? '',
                                      height: 170,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                snapshot.data!.name ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: AAColors.red),
                              ),
                              const SizedBox(height: 10.0),
                              Text(snapshot.data!.detail ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 15.0),
                              const ShortInfoQuiz(
                                  icon: Icons.timer_outlined,
                                  text: 'No tiene tiempo limite'),
                              const SizedBox(height: 15.0),
                              const ShortInfoQuiz(
                                  icon: Icons.quiz_outlined,
                                  text: '5 preguntas'),
                              const SizedBox(height: 15.0),
                              const ShortInfoQuiz(
                                  icon: Icons.check_circle_outlined,
                                  text: 'Varios intentos'),
                              const SizedBox(height: 15.0),
                              Center(
                                child: MainActionButton(
                                    text: 'Empezar',
                                    width: 150,
                                    height: 45,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/quiz-attempt',
                                          arguments: {
                                            'humanAnatomyId': snapshot.data?.id,
                                          });
                                    }),
                              )
                            ],
                          )),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorMessage(onRefresh: () {});
                  } else {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: AAColors.red,
                        size: 50.0,
                      ),
                    );
                  }
                })));
  }
}

class ShortInfoQuiz extends StatelessWidget {
  final IconData icon;
  final String text;

  const ShortInfoQuiz({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.black,
        ),
        SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}
