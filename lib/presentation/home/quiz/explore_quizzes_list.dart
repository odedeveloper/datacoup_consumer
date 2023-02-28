import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_question.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreQuizListItem extends StatelessWidget {
  final QuizItemModel item;
  const ExploreQuizListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => QuizQuestion(quiz: item));
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: greyColor,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 260.w,
                  child: Text(item.name.tr,
                      // textAlign: alignment,
                      style: TextStyle(
                        color: mediumBlueGreyColor,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w800,
                        fontFamily: AssetConst.QUICKSAND_FONT,
                      )),
                ),
                const Spacer(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: deepOrangeColor,
                      ),
                      child: Text('${item.count} Questions',
                          // textAlign: alignment,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          )),
                    ),
                    Spacer(),
                    Text('${item.timeLimit} mins',
                        // textAlign: alignment,
                        style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

                // TextButton(
                //     onPressed: () {
                //       Get.to(() => QuizQuestion(quiz: item));
                //     },
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //             Colors.blue.shade500),
                //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5.0),
                //           // side: BorderSide(color: Colors.red)
                //         ))),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text("Take Quiz".tr,
                //             style: const TextStyle(
                //                 letterSpacing: 0.9,
                //                 fontSize: 14,
                //                 color: Colors.white,
                //                 fontFamily: AssetConst.RALEWAY_FONT)),
                //       ],
                //     )),
              ])),
    );
  }
}
