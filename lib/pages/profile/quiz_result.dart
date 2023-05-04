
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:flutter/material.dart';
import '../../utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';

class QuizResult extends StatefulWidget {
  final double score;
  const QuizResult({Key? key, required this.score}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {

  late double _score;
  String imageRoute = "";
  String messageResult = "";
  double percentScore = 0.0;

  void assignValues(double score) {
    if (score >= 0 && score < 10) {
      setState(() {
        imageRoute = "assets/image-low-score.png";
        messageResult = "PUEDES HACERLO MEJOR";

      });
    } else if (score >= 10 && score < 15) {
      setState(() {
        imageRoute = "assets/image-mid-score.png";
        messageResult = "BUEN INTENTO";
      });
    } else if (score >= 15 && score <= 20) {
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
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.3,
                     ),
                      const SizedBox(height: 10),
                      Text(
                        messageResult,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$percentScore% de aciertos",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: (percentScore <= 25.0) ?
                          AAColors.red : (percentScore < 75.0) ?
                          AAColors.amber :  AAColors.green
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: AAColors.white,
                        child: Padding(
                          padding:  const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text(
                                  "Cuestionario completado con éxito.",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Usted realizó el cuestionaro “nombre del cuestionario”, que conto de 5 preguntas, de las cuales ${_score~/5} respuestas fueron las correcta.",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 20),
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
                                  onPressed: (){}
                              ),
                              const SizedBox(height: 15),
                              MainActionButton(
                                height: 50,
                                width: 200,
                                  text: "Ver cuestionarios",
                                  onPressed: (){}
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
          )
      ),
    );
  }
}
