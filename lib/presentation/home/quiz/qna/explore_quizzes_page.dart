import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/explore_quizzes_list.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list_controller.dart';

class QuizzesList extends StatelessWidget {
  final String odenId;
  QuizzesList({Key? key, required this.odenId}) : super(key: key);
  final quizListController = Get.put(QuizListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10),
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
              const SizedBox(
                width: 20,
              ),
              Text(
                "All Quizzes",
                style: TextStyle(
                  // letterSpacing: 1.7,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: AssetConst.QUICKSAND_FONT,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 50,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GetBuilder<QuizListController>(builder: (qcontroller) {
              return (qcontroller.isUpdating && qcontroller.quizzesList.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: deepOrangeColor,
                    ))
                  : qcontroller.quizzesList.isEmpty
                      ? Text('No Quizzes Available!',
                          style: themeTextStyle(context: context, fsize: 18))
                      : ListView.builder(
                          itemCount: qcontroller.quizzesList.length,
                          itemBuilder: (context, index) {
                            return ExploreQuizListItem(
                                qcontroller.quizzesList[index]);
                          });
            }),
          ),
        ]),
      ),
    );
  }
}
