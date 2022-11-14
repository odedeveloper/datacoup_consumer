import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/explore_quizzes_page.dart';
import 'package:datacoup/presentation/home/quiz/qna_homepage_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/user_quiz_history_list.dart';

class QnaProfile extends StatefulWidget {
  const QnaProfile({Key? key}) : super(key: key);

  @override
  State<QnaProfile> createState() => _QnaProfileState();
}

class _QnaProfileState extends State<QnaProfile> {
  // const QnaProfile({Key? key}) : super(key: key);
  final qnaHomePageController = Get.find<QnaHomePageController>();
  final homeController = Get.find<HomeController>();

  final quizHistoryResultController = Get.put(QuizHistoryResultController());

  @override
  void didChangeDependencies() {
    if (homeController.user != null) {
      qnaHomePageController.loadUserDataFirst();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "Quizzes",
      //     style: themeTextStyle(
      //       context: context,
      //       fsize: klargeFont(context),
      //       fweight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => qnaHomePageController.quizMainLoader.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    GetBuilder<QnaHomePageController>(
                        init: QnaHomePageController(),
                        builder: (controller) {
                          return Stack(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      AssetConst.CIRCLES,
                                      errorBuilder: (context, error, map) {
                                        return Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(75)),
                                        );
                                      },
                                      height: 250.0,
                                      width: 350.0,
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.065,
                                    left: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(75),
                                        child: controller.badge == ''
                                            ? const ShimmerBox(
                                                height: 150,
                                                width: 150,
                                                radius: 75)
                                            : Image.asset(
                                                AssetConst
                                                    .BADGES[controller.badge]
                                                    .toString(),
                                                errorBuilder:
                                                    (context, error, map) {
                                                  return Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(75)),
                                                  );
                                                },
                                                height: 100.0,
                                                width: 100.0,
                                              )),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: height(context)! * 0.23,
                                left: MediaQuery.of(context).size.width * 0.38,
                                child: controller.bestScore != ''
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 8, 20, 8),
                                        decoration: BoxDecoration(
                                            color: darkSkyBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "${controller.bestScore}/100",
                                          style: TextStyle(
                                            // letterSpacing: 1.7,
                                            color: Colors.white,
                                            fontSize: width(context)! * 0.025,
                                            fontWeight: FontWeight.w800,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              Positioned(
                                top: height(context)! * 0.23,
                                left: MediaQuery.of(context).size.width * 0.3,
                                child: controller.bestScore == ''
                                    ? Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: darkSkyBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "You haven't taken any quiz yet",
                                          style: TextStyle(
                                            // letterSpacing: 1.7,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: width(context)! * 0.025,
                                            fontWeight: FontWeight.w800,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: MediaQuery.of(context).size.width * 0.62,
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: darkSkyBlueColor),
                                    // margin: const EdgeInsets.fromLTRB(180, 100, 0, 0),
                                    child: Text(
                                      controller.badge != ''
                                          ? controller.badge
                                          : "Digital Novice",
                                      style: TextStyle(
                                          fontFamily: AssetConst.QUICKSAND_FONT,
                                          fontSize: width(context)! * 0.025,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: GetBuilder<QnaHomePageController>(
                          builder: (controller) {
                        return Text(
                            StringConst.BADGE_WISE_CENTER_TEXT[controller.badge]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // letterSpacing: 1.7,
                              color: Theme.of(context).primaryColor,
                              fontSize: width(context)! * 0.035,
                              fontWeight: FontWeight.w800,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                            ));
                      }),
                    ),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GetBuilder<HomeController>(builder: (controller) {
                        return controller.user == null
                            ? TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            redOpacityColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Colors.red)
                                    ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Explore Quizzes".tr,
                                        style: TextStyle(
                                            letterSpacing: 0.9,
                                            fontSize: width(context)! * 0.028,
                                            color: Colors.white,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT)),
                                  ],
                                ))
                            : TextButton(
                                onPressed: () {
                                  Get.to(() => QuizzesList(
                                        odenId: controller.user!.value.odenId!,
                                      ));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange.shade800),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // side: BorderSide(color: Colors.red)
                                    ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Explore Quizzes".tr,
                                        style: TextStyle(
                                            letterSpacing: 0.9,
                                            fontSize: width(context)! * 0.028,
                                            color: Colors.white,
                                            fontFamily:
                                                AssetConst.RALEWAY_FONT)),
                                  ],
                                ));
                      }),
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Recent Quizzes",
                            style: TextStyle(
                              // letterSpacing: 1.7,
                              color: Theme.of(context).primaryColor,
                              fontSize: width(context)! * 0.035,
                              fontWeight: FontWeight.w800,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GetBuilder<HomeController>(builder: (controller) {
                        return controller.user == null
                            ? Text("User History",
                                style: TextStyle(
                                  // letterSpacing: 1.7,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: width(context)! * 0.030,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: AssetConst.QUICKSAND_FONT,
                                ))
                            : UserHistoryList(
                                odenId: controller.user!.value.odenId!);
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
