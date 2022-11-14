import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_question.dart';

class ExploreQuizListItem extends StatelessWidget {
  final QuizItemModel item;
  const ExploreQuizListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).backgroundColor,
            boxShadow: const [
              BoxShadow(blurRadius: 1, spreadRadius: 0.1),
            ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 130,
                child: Text(item.name.tr,
                    // textAlign: alignment,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: AssetConst.QUICKSAND_FONT,
                    )),
              ),
              const Spacer(),
              Text('${item.timeLimit} mins',
                  // textAlign: alignment,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
              const Spacer(),
              Text('${item.count} Qs',
                  // textAlign: alignment,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Get.to(() => QuizQuestion(quiz: item));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade500),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Take Quiz".tr,
                          style: const TextStyle(
                              letterSpacing: 0.9,
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: AssetConst.RALEWAY_FONT)),
                    ],
                  )),
              const SizedBox(width: 10),
            ]));
  }
}
