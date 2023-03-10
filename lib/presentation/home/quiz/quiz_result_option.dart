import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';

class QuizResultOption extends StatelessWidget {
  final int questionIndex;
  final int optionIndex;
  bool isQuizHistoryResult = false;
  QuizResultOption(
      this.questionIndex, this.optionIndex, this.isQuizHistoryResult,
      {Key? key})
      : super(key: key);
  final _quizController = Get.put(QuizController());
  var controller;
  Map<String, bool> status = {};
  @override
  Widget build(BuildContext context) {
    if (isQuizHistoryResult) {
      controller = Get.find<QuizHistoryResultController>();
      status = controller.getOptionStatus(optionIndex, questionIndex);
    } else {
      controller = Get.find<QuizController>();
      status = controller.getOptionStatus(optionIndex, questionIndex);
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: 370.w,
      decoration: BoxDecoration(
          color: (status["selected"]!)
              ? (status["correct"]!)
                  ? Colors.greenAccent.shade400
                  : Colors.red.shade100
              : (status["correct"]!)
                  ? Color.fromARGB(255, 198, 248, 212)
                  : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 0.2, spreadRadius: 0.5)]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: controller.getOptionColor(optionIndex, questionIndex) ==
                        Colors.red
                    ? Colors.red
                    : Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle),
            child: (status["selected"]!)
                ? (status["correct"]!)
                    ? Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.green.shade600,
                      )
                    : const Icon(Icons.close, size: 15, color: Colors.white)
                : Text(
                    String.fromCharCode(optionIndex + 65),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              controller
                  .quiz.questions[questionIndex].options[optionIndex].item,
              softWrap: true,
              // maxLines: 2,
              /*style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: (status["selected"]!)
                    ? (status["correct"]!)
                        ? Colors.green.shade900
                        : Colors.red
                    : (status["correct"]!)
                        ? Colors.grey.shade900
                        : Theme.of(context).appBarTheme.backgroundColor,
              ),*/
              style: themeTextStyle(
                context: context,
                fsize: 15.0,
                fweight: FontWeight.w500,
                tColor: (status["selected"]!)
                    ? (status["correct"]!)
                        ? Colors.green.shade900
                        : Colors.red
                    : (status["correct"]!)
                        ? Colors.grey.shade900
                        // : Theme.of(context).appBarTheme.backgroundColor,
                        : Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
