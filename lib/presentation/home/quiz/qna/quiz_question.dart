import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_result.dart';
import 'package:datacoup/presentation/home/quiz/quiz_option.dart';

class QuizQuestion extends StatelessWidget {
  QuizItemModel quiz = QuizItemModel(
      quizId: '',
      topic: '',
      count: '',
      timeLimit: '',
      timeStamp: '',
      questions: [],
      name: '');

  QuizQuestion({Key? key, required this.quiz}) : super(key: key);

  final quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    quizController.updateQuiz(quiz);
    quizController.updateTimeStamp();

    return GetBuilder<QuizController>(builder: (quizController) {
      return quizController.quiz.topic == ''
          ? Text(StringConst.SPLASH_TEXT,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1,
                  fontSize: 12,
                  fontFamily: AssetConst.RALEWAY_FONT,
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.w700))
          : SafeArea(
              child: Scaffold(
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(children: [
                        Container(
                            padding: const EdgeInsets.only(left: 5),
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: blueGreyLight,
                            ),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back_ios,
                                    color: darkBlueGreyColor))),
                        const Spacer(),
                        Text(
                          quizController.quiz.name,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 40,
                        )
                      ]),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 10,
                        child: LinearProgressIndicator(
                          value: (quizController.questionIndex + 1) /
                              quizController.quiz.questions.length,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 130.0,
                        margin: const EdgeInsets.only(
                            bottom: 10.0, left: 30.0, right: 30.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          // color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            quizController
                                .quiz
                                .questions[quizController.questionIndex]
                                .question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ...(quizController.quiz
                              .questions[quizController.questionIndex].options)
                          .map(
                        (answer) => Answer(
                          index: quizController.quiz
                              .questions[quizController.questionIndex].options
                              .indexOf(answer),
                          answerText: answer.item,
                          isSelected: quizController.isAnswerSelected(answer),
                          answerTap: () {
                            quizController.questionAnswered(answer);
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50.0),
                              ),
                              onPressed:
                                  quizController.answersSelected.isNotEmpty
                                      ? () {
                                          if (quizController.endOfQuiz) {
                                            //send to result page and controller should call endpoint for submitActivity
                                            // _quizController.calculateScore();
                                            Get.to(() => QuizResult());
                                          }
                                          if (quizController
                                              .answersSelected.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please select an answer before going to the next question'),
                                            ));
                                            return;
                                          }
                                          quizController.nextQuestion();
                                        }
                                      : null,
                              child: Text(
                                quizController.endOfQuiz
                                    ? 'FINISH'
                                    : 'CONTINUE',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
