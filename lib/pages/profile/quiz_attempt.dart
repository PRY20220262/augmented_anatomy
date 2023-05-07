import 'package:augmented_anatomy/models/questions.dart';
import 'package:augmented_anatomy/pages/profile/quiz_result.dart';
import 'package:augmented_anatomy/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';

class QuizAttempt extends StatefulWidget {
  const QuizAttempt({Key? key}) : super(key: key);

  @override
  State<QuizAttempt> createState() => _QuizAttemptState();
}

class _QuizAttemptState extends State<QuizAttempt> {
  bool isLoading = true;
  int indexQuestion = 0;
  int _selectedChoice = -1;
  int score = 0;
  double routerScore = 0;
  late int quizAttemptId;
  List<Question>? questionList;
  QuizService quizService = QuizService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    getQuestions();
    super.initState();
  }

  Future<void> getQuestions() async {
    try {
      questionList = await quizService.getAllQuestionsAndChoices(id: 3);
      createQuizAttempt();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
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
      double? finalScore =
          await quizService.updateQuizAttemptScore(quizAttemptId, score);
      if (finalScore != null) {
        setState(() {
          routerScore = finalScore;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResult(score: routerScore),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _validateRightAnswer(bool lastQuestion) {
    if (questionList![indexQuestion].answers?[_selectedChoice].isCorrect ==
        true) {
      setState(() {
        score = score + 5;
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
      appBar: AAAppBar(context, back: true, title: 'Cuestionario'),
      body: SafeArea(
          child: isLoading
              ? const Center(
                  child: SpinKitFadingCircle(
                    color: AAColors.red,
                    size: 50.0,
                  ),
                )
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pregunta ${indexQuestion + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: AAColors.red),
                            ),
                            Text(
                              '5 Pts',
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
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                questionList?[indexQuestion].answers?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedChoice = index;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedChoice == index
                                          ? AAColors.red
                                          : AAColors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: _selectedChoice == index
                                                ? AAColors.white
                                                : AAColors.gray,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          padding: const EdgeInsets.only(
                                              right: 17,
                                              left: 17,
                                              top: 8,
                                              bottom: 8),
                                          child: Text(
                                              index == 0
                                                  ? 'A'
                                                  : index == 1
                                                      ? 'B'
                                                      : index == 2
                                                          ? 'C'
                                                          : 'D',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: _selectedChoice ==
                                                              index
                                                          ? AAColors.red
                                                          : AAColors.white)),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                            '${questionList![indexQuestion].answers?[index].choice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color:
                                                        _selectedChoice == index
                                                            ? AAColors.white
                                                            : AAColors.black)),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: _selectedChoice == -1
                              ? const NotAllowedActionButton(
                                  text: 'Siguiente',
                                  width: 150,
                                  height: 45,
                                )
                              : MainActionButton(
                                  text: 'Siguiente',
                                  width: 150,
                                  height: 45,
                                  onPressed: () {
                                    if (indexQuestion + 1 !=
                                        questionList?.length) {
                                      _validateRightAnswer(false);
                                      _scrollController.animateTo(
                                        0.0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeOut,
                                      );
                                    } else {
                                      _validateRightAnswer(true);
                                    }
                                  }),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
