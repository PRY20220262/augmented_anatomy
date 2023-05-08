
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:augmented_anatomy/pages/quiz/quiz_attempt.dart';
import '../../utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';

import '../../widgets/note_dialog.dart';

class QuizResult extends StatefulWidget {
  final double score;
  final int humanAnatomyId;
  const QuizResult({Key? key, required this.score, required this.humanAnatomyId}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {

  late double _score;
  String imageRoute = "";
  String messageResult = "";
  double percentScore = 0.0;

  void assignValues(double score) {
    if (score >= 0 && score <= 4) {
      setState(() {
        imageRoute = "assets/image-low-score.png";
        messageResult = "PUEDES HACERLO MEJOR";

      });
    } else if (score >= 5 && score < 12) {
      setState(() {
        imageRoute = "assets/image-mid-score.png";
        messageResult = "BUEN INTENTO";
      });
    } else if (score >= 13 && score <= 20) {
      setState(() {
        imageRoute = "assets/image-high-score.png";
        messageResult = "FELICIDADES!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _score = widget.score;
    assignValues(_score);
    setState(() {
      percentScore = _score * 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      assignValues(_score);
    });
    return Scaffold(
      backgroundColor: AAColors.backgroundGrayView,
      appBar: AAAppBar(context, back: true, title: 'Cuestionario'),
      body: SafeArea(
          child: SingleChildScrollView(
              child: WillPopScope(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imageRoute,
                            fit: BoxFit.fill,
                            height: 160,
                            width: 160,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            messageResult,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${percentScore.toInt()}% de aciertos",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: (percentScore <= 25.0) ?
                                AAColors.red : (percentScore < 75.0) ?
                                AAColors.amber :  AAColors.green
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: AAColors.white,
                            ),
                            child: Padding(
                              padding:  const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(
                                    "Cuestionario completado con éxito.",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Usted realizó el cuestionario ',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        TextSpan(
                                          text: 'Cuestionario de Laringe',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ', que contó de ',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        TextSpan(
                                          text: '5 preguntas',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ', de las cuales las ',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        TextSpan(
                                          text: '${_score~/4} respuestas',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: (percentScore <= 25.0) ?
                                              AAColors.red : (percentScore < 75.0) ?
                                              AAColors.amber :  AAColors.green
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' fueron las correctas.',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  _score == 20.0 ? Text(
                                    "Para ver los cuestionarios realizados, de click en el siguiente botón:",
                                    style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ) : Container(),
                                  const SizedBox(height: 5),
                                  _score == 20.0 ? Container() : MainActionButton(
                                      height: 50,
                                      width: 200,
                                      text: "Realziar nuevo intento",
                                      onPressed: (){
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return InformationDialog(
                                                title: 'Nuevo Intento',
                                                message: 'Estas apunto de iniciar un nuevo intento del cuestionario recien realizado.',
                                                cancelButtonText: 'Cancelar',
                                                onCancelPressed: (){
                                                  Navigator.pop(context, false);
                                                },
                                                confirmButtonText: 'Nuevo Intento',
                                                onConfirmPressed: (){
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => QuizAttempt(
                                                        id: widget.humanAnatomyId,
                                                      ),
                                                    ),
                                                        (route) => false,
                                                  );
                                                },
                                              );
                                            }
                                        );

                                      }
                                  ),
                                  const SizedBox(height: 10),
                                  MainActionButton(
                                      height: 50,
                                      width: 200,
                                      text: "Ver cuestionarios",
                                      onPressed: (){
                                        Navigator.of(context).pushNamed('/list-quiz-results');
                                      }
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                onWillPop: () async {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                        (Route<dynamic> route) => false,
                  );
                  return false;
                },
              )
          )
      ),
    );
  }
}
