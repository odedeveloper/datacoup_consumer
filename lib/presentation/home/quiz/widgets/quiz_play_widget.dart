import 'package:datacoup/export.dart';

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
              const Expanded(
                child: QuizProgressWidget(ticks: 5),
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
                              final data =
                                  quizItem!.questions![index].options![i];
                              return Container(
                                padding: const EdgeInsets.all(18),
                                margin: EdgeInsets.all(height(context)! * 0.01),
                                width: double.infinity,
                                height: height(context)! * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        kBorderRadius + 12),
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: 0.3, blurRadius: 0.2)
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
                              );
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
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: height(context)! * 0.15,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width(context)! * 0.25,
                height: height(context)! * 0.04,
                child: RoundedElevatedButton(
                  onClicked: () {},
                  color: Colors.blueGrey,
                  title: "Back",
                ),
              ),
              SizedBox(
                width: width(context)! * 0.25,
                height: height(context)! * 0.04,
                child: RoundedElevatedButton(
                  onClicked: () {
                    pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                  },
                  title: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
