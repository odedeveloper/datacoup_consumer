import 'dart:developer';

import 'package:datacoup/domain/model/quiz_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/widgets/quiz_progress_widget.dart';

class QuizPlayWidget extends GetWidget<QuizController> {
  final QuizItem? quizItem;
  QuizPlayWidget({super.key, this.quizItem});

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: QuizProgressWidget(ticks: quizItem!.questions!.length),
              ),
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: quizItem!.questions!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              quizItem!.questions![index].question!,
                              textAlign: TextAlign.center,
                              style: themeTextStyle(
                                context: context,
                                fsize: kmaxExtraLargeFont(context),
                                fweight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: List.generate(
                                quizItem!.questions![index].options!.length,
                                (i) {
                              return GetBuilder<QuizController>(
                                  builder: (cont) {
                                final data =
                                    quizItem!.questions![index].options![i];
                                return InkWell(
                                  onTap: () async {
                                    for (var element in quizItem!
                                        .questions![index].options!) {
                                      if (controller.options!
                                          .contains(element)) {
                                        controller.options!
                                            .removeWhere((e) => e == element);
                                      }
                                    }
                                    log("add opt ${controller.options!.length}");
                                    await controller.selectUserOptions(
                                        index: index, option: data);
                                    if (index ==
                                        quizItem!.questions!.length - 1) {
                                      controller.showNextButtom(false);
                                      controller.showSubmitButtom(true);
                                    } else {
                                      controller.showNextButtom(true);
                                    }
                                    controller.update();
                                  },
                                  child: cont.options!.contains(data)
                                      ? Container(
                                          padding: const EdgeInsets.all(18),
                                          margin: EdgeInsets.all(
                                              height(context)! * 0.01),
                                          width: double.infinity,
                                          height: height(context)! * 0.07,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kBorderRadius + 12),
                                              color: Colors.green,
                                              boxShadow: const [
                                                BoxShadow(
                                                    spreadRadius: 0.3,
                                                    blurRadius: 0.2)
                                              ]),
                                          child: Center(
                                            child: Text(
                                              data.item!,
                                              style: themeTextStyle(
                                                context: context,
                                                fsize: klargeFont(context),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(18),
                                          margin: EdgeInsets.all(
                                              height(context)! * 0.01),
                                          width: double.infinity,
                                          height: height(context)! * 0.07,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kBorderRadius + 12),
                                              color: Theme.of(context)
                                                  .appBarTheme
                                                  .backgroundColor,
                                              boxShadow: const [
                                                BoxShadow(
                                                    spreadRadius: 0.3,
                                                    blurRadius: 0.2)
                                              ]),
                                          child: Center(
                                            child: Text(
                                              data.item!,
                                              style: themeTextStyle(
                                                context: context,
                                                fsize: klargeFont(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              });
                            }),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Obx(
        () => controller.progressList.isNotEmpty
            ? Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: height(context)! * 0.15,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.options!.isNotEmpty &&
                              controller.options!.isEmpty
                          ? SizedBox(
                              width: width(context)! * 0.25,
                              height: height(context)! * 0.04,
                              child: RoundedElevatedButton(
                                onClicked: () {
                                  pageController.previousPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                },
                                color: Colors.blueGrey,
                                title: "Back",
                              ),
                            )
                          : const SizedBox(),
                      controller.options!.isNotEmpty
                          ? SizedBox(
                              width: width(context)! * 0.25,
                              height: height(context)! * 0.04,
                              child: RoundedElevatedButton(
                                onClicked: () {
                                  if (controller.showNextButtom.value) {
                                    pageController.nextPage(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut);
                                  } else {}
                                },
                                title: controller.showNextButtom.value
                                    ? "Next"
                                    : "Submit",
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ))
            : const SizedBox.shrink(),
      ),
    );
  }
}
