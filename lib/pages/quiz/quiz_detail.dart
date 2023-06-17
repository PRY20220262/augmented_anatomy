import 'package:augmented_anatomy/pages/quiz/quiz_attempt.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../services/human_anatomy_service.dart';
import '../../utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/error.dart';

import '../../widgets/cards.dart';

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
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: AAColors.backgroundWhiteView,
        appBar: AAAppBar(context, back: true, title: 'Cuestionario'),
        body: SafeArea(
            child: FutureBuilder(
                future: humanAnatomyService.getById(args['humanAnatomyId']),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    snapshot.data!.image ?? '',
                                    height: 170,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: AAColors.mainColor),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                    "Atrévete a probar tus conocimientos adquiridos mediante preguntas del cuestionario, que permitirán saber tu nivel de aprendizaje. Una vez finalizado, se mostrarán tu porcentaje de respuestas correctas y la cantidad de preguntas respondidas correctamente. Ten en cuenta la siguiente información para tener éxito en tu cuestionario. ¡Mucha suerte!",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            Column(
                              children: const [
                                ShortInfoQuiz(
                                    icon: Icons.timer_outlined,
                                    text: 'No tiene tiempo limite'),
                                SizedBox(height: 15.0),
                                ShortInfoQuiz(
                                    icon: Icons.quiz_outlined,
                                    text: '5 preguntas'),
                                SizedBox(height: 15.0),
                                ShortInfoQuiz(
                                    icon: Icons.check_circle_outlined,
                                    text: 'Varios intentos'),
                                SizedBox(height: 15.0),
                                ShortInfoQuiz(
                                    icon: Icons.lock_outline,
                                    text: 'No se puede reanudar el examen'),
                              ],
                            ),
                            Center(
                              child: NewMainActionButton(
                                  text: 'Empezar',
                                  width: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizAttempt(
                                          id: snapshot.data!.id!,
                                          humanAnatomyName: snapshot.data!.name!
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  }),
                            )
                          ],
                        ));
                  } else if (snapshot.hasError) {
                    return ErrorMessage(onRefresh: () {});
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
