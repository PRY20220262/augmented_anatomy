import 'package:augmented_anatomy/models/quiz_attempt_detail_grouped.dart';
import 'package:augmented_anatomy/services/quiz_service.dart';
import 'package:augmented_anatomy/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/augmented_anatomy_colors.dart';
import '../../widgets/error.dart';

class ListQuizResults extends StatefulWidget {
  const ListQuizResults({Key? key}) : super(key: key);

  @override
  State<ListQuizResults> createState() => _ListQuizResultsState();
}

class _ListQuizResultsState extends State<ListQuizResults> {
  QuizService quizService = QuizService();
  List<QuizAttemptDetailGrouped>? quizAttemptDetailGrouped;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedTest();
  }

  Future<void> fetchedTest() async {
    try {
      quizAttemptDetailGrouped =
          await quizService.fetchQuizAttemptsGroupedByUserId();
      quizAttemptDetailGrouped?.forEach((element) {
        print(element.nameHumanAnatomy);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AAColors.backgroundGrayView,
      appBar: AAAppBar(context, back: true, title: 'Mis Cuestionarios'),
      body: SafeArea(
          child: FutureBuilder(
        future: quizService.fetchQuizAttemptsGroupedByUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuizAttemptCard(
                        index: index,
                        quizAttemptDetail: snapshot.data![index],
                        onPress: () {});
                  },
                ));
          } else if (snapshot.hasError) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ErrorMessage(
                        messageError:
                            'Ocurrio un error al momento de traer los cuestioanrios resueltos',
                        onRefresh: () {
                          quizService.fetchQuizAttemptByUserId();
                        })
                  ]),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    EmptyElementError(
                      title: 'Por el momento no tiene cuestionarios realizados',
                      messageError:
                          'Visualiza un módelo de realidad aumentada y aprende acerca de un sistema u órgano para realizar un cuestionario. Luego los podrá visualizar en esta pantalla.',
                    )
                  ]),
            );
          } else {
            return const Center(
              child: SpinKitFadingCircle(
                color: AAColors.red,
                size: 50.0,
              ),
            );
          }
        },
      )),
    );
  }
}
