import 'package:augmented_anatomy/models/questions.dart';
import 'package:augmented_anatomy/pages/quiz/quiz_result.dart';
import 'package:augmented_anatomy/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';

import '../../utils/enums.dart';
import '../../widgets/button.dart';
import '../../widgets/error.dart';

class QuizAttempt extends StatefulWidget {
  final int id;
  const QuizAttempt({Key? key, required this.id}) : super(key: key);

  @override
  State<QuizAttempt> createState() => _QuizAttemptState();
}

class _QuizAttemptState extends State<QuizAttempt> {

  bool notFoundResource = false;
  bool isLoading = true;
  int indexQuestion = 0;
  int _selectedChoice = -1;
  int score = 0;
  double routerScore = 0;
  late int quizAttemptId;
  List<int> aux = [];
  List<Question>? questionList;
  List<int> lengthQuestionChoices = [];
  QuizService quizService = QuizService();
  final ScrollController _scrollController = ScrollController();
  int lengthAnswersString = 0;

  @override
  void initState() {
    // TODO: implement initState
    getQuestions();
    super.initState();
  }

  Future<void> getQuestions() async {
    setState(() {
      isLoading = true;
    });
    try {
      questionList = await quizService.getAllQuestionsAndChoices(id: widget.id);
      questionList?.forEach((element) {
        for (var i = 0; i < element.answers!.length; i++) {
          lengthAnswersString = lengthAnswersString + element.answers![i].choice!.length;
        }
        lengthQuestionChoices.add(lengthAnswersString);
        lengthAnswersString = 0;
      });
      setState(() {
        aux = lengthQuestionChoices;
        print(lengthQuestionChoices);
      });
      createQuizAttempt();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        notFoundResource = true;
      });
    }
  }

  Future<void> createQuizAttempt() async {
    try {
      var quizAttempt = await quizService.createQuizAttempt(3);
      setState(() {
        quizAttemptId = quizAttempt.id ?? 0;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateQuizAttemptScore() async {
    try {
      double? finalScore = await quizService.updateQuizAttemptScore(quizAttemptId, score);
      if (finalScore != null) {
        setState(() {
          routerScore = finalScore;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResult(score: routerScore, humanAnatomyId: widget.id),
          ),
        );
      }

    } catch (e) {
      print(e);
    }
  }

  void _validateRightAnswer(bool lastQuestion){
    if (questionList![indexQuestion].answers?[_selectedChoice].isCorrect == true) {
      setState(() {
        score = score + 4;
      });
    }
    if (!lastQuestion) {
      setState(() {
        indexQuestion = indexQuestion + 1;
        _selectedChoice = -1;
      });
    } else {
      updateQuizAttemptScore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AAColors.backgroundGrayView,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cuestionario',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leadingWidth: 70,
        automaticallyImplyLeading: false, // esta propiedad evita que se muestre el botón de retroceso en el AppBar
      ),
      body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              !notFoundResource ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.0),
                    ),
                    contentPadding: EdgeInsets.all(20.0),
                    content: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Adevertencia',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Si abandonas el examen, se guardara el intento realizado con la nota actual y no se podra retomar el cuestionario.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge,
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MainActionButton(
                                text: 'Cancelar',
                                type: ButtonType.secondary,
                                height: 40,
                                width: 120,
                                onPressed: () => Navigator.pop(context, false)),
                              MainActionButton(
                                  text: 'Abandonar',
                                  height: 40,
                                  width: 120,
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/home',
                                          (Route<dynamic> route) => false,
                                    );
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ) : Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                    (Route<dynamic> route) => false,
              );
              return false;
            },
            child: isLoading ?
            const Center(
              child: SpinKitFadingCircle(
                color: AAColors.red,
                size: 50.0,
              ),
            ) : !notFoundResource ? SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pregunta ${indexQuestion + 1}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AAColors.red),
                          ),
                          Text(
                            '4 Pts',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: AAColors.black,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${questionList?[indexQuestion].title}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: aux[indexQuestion] >= 350 ? MediaQuery.of(context).size.height * 0.90 :
                        aux[indexQuestion] >= 300 ? MediaQuery.of(context).size.height * 0.85 :
                        aux[indexQuestion] >= 250 ? MediaQuery.of(context).size.height * 0.75 :
                        MediaQuery.of(context).size.height * 0.70
                        ,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: questionList?[indexQuestion].answers?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedChoice = index;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedChoice == index ? AAColors.red : AAColors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: _selectedChoice == index ? AAColors.white : AAColors.gray,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        padding: const EdgeInsets.only(right: 17, left: 17, top: 8, bottom: 8),
                                        child: Text(
                                            index == 0 ? 'A' : index == 1 ? 'B' : index == 2 ? 'C' : 'D',
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: _selectedChoice == index ? AAColors.red : AAColors.white
                                            )
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Text(
                                            '${questionList![indexQuestion].answers?[index].choice}',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                color: _selectedChoice == index ? AAColors.white : AAColors.black
                                            )
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: _selectedChoice == -1 ?
                        const NotAllowedActionButton(
                          text: 'Siguiente',
                          width: 150,
                          height: 45,
                        ) :
                        MainActionButton(
                            text: 'Siguiente',
                            width: 150,
                            height: 45,
                            onPressed: (){
                              if (indexQuestion + 1 != questionList?.length) {
                                _validateRightAnswer(false);
                                _scrollController.animateTo(
                                  0.0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                              } else {
                                _validateRightAnswer(true);
                              }
                            }
                        ),
                      )
                    ],
                  ),
                )
            ) : ErrorMessage(
                onRefresh: (){
                  getQuestions();
                },
              messageError: 'El cuestionario que intentas realizar, no se encuentra disponible por el momento.',
            )
          )
      ),
    );
  }
}
