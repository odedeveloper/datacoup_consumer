import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_result_option.dart';

class QuizResultListItem extends StatelessWidget {
  final int questionIndex;
  QuizResultListItem(this.questionIndex, {Key? key}) : super(key: key);
  final quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(builder: (quizController) {
      return Container(
          width: 370,
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // color: extraLightBlackColor,
          ),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: quizController.correctlyAnsweredQuestions
                                .contains(questionIndex)
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ),
                      child: Text(
                          quizController.correctlyAnsweredQuestions
                                  .contains(questionIndex)
                              ? "Correct"
                              : "Wrong",
                          // textAlign: alignment,
                          style: TextStyle(
                            color: quizController.correctlyAnsweredQuestions
                                    .contains(questionIndex)
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: Text("Ques - ${(questionIndex + 1).toString()}",
                          // textAlign: alignment,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          )),
                    ),
                  ]),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  quizController.quiz.questions[questionIndex].question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    // color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  ...(quizController.quiz.questions[questionIndex].options).map(
                    (answer) => QuizResultOption(
                        questionIndex,
                        quizController.quiz.questions[questionIndex].options
                            .indexOf(answer),
                        false),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (quizController.quiz.questions[questionIndex].message != '')
                Center(
                  child: Container(
                    width: 370,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.red.shade500, width: 1),
                      color: Colors.red.shade100,
                    ),
                    child: Text(
                      quizController.quiz.questions[questionIndex].message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ));
    });
  }
}

class ActivityResultListItem extends StatelessWidget {
  final int questionIndex;
  ActivityResultListItem(this.questionIndex, {Key? key}) : super(key: key);
  final _quizController = Get.find<QuizHistoryResultController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 370,
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _quizController.correctlyAnsweredQuestions
                              .contains(questionIndex)
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                    child: Text(
                        _quizController.correctlyAnsweredQuestions
                                .contains(questionIndex)
                            ? "Correct"
                            : "Wrong",
                        // textAlign: alignment,
                        style: TextStyle(
                          color: _quizController.correctlyAnsweredQuestions
                                  .contains(questionIndex)
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Text("Ques - ${(questionIndex + 1).toString()}",
                        // textAlign: alignment,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                        )),
                  ),
                ]),
            const SizedBox(height: 10),
            Center(
              child: Text(
                _quizController.quiz.questions[questionIndex].question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  // color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                ...(_quizController.quiz.questions[questionIndex].options).map(
                  (answer) => QuizResultOption(
                    questionIndex,
                    _quizController.quiz.questions[questionIndex].options
                        .indexOf(answer),
                    true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_quizController.quiz.questions[questionIndex].message != '')
              Center(
                child: Container(
                  width: 370,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.red.shade500, width: 1),
                    color: Colors.red.shade100,
                  ),
                  child: Text(
                    _quizController.quiz.questions[questionIndex].message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}

class QuizHistoryResultList extends StatelessWidget {
  final bool isQuizHistoryResult;
  const QuizHistoryResultList({Key? key, this.isQuizHistoryResult = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isQuizHistoryResult) {
      return Column(children: [
        GetBuilder<QuizController>(builder: (controller) {
          return Column(
              children: List<Widget>.generate(controller.quiz.questions.length,
                  (int index) {
            return QuizResultListItem(index);
          }));
        })
      ]);
    } else {
      var controller = Get.find<QuizHistoryResultController>();
      return Column(
          children: List<Widget>.generate(controller.quiz.questions.length,
              (int index) {
        return ActivityResultListItem(index);
      }));
    }
  }
}
