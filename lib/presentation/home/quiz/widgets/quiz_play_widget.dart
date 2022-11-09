import 'package:datacoup/export.dart';

import 'quiz_progress_widget.dart';

class QuizPlayWidget extends StatelessWidget {
  const QuizPlayWidget({super.key});

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
                child: Center(child: QuizProgressWidget(ticks: 4)),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "What is the Colour of Apple?",
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
                    4,
                    (index) => Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.all(height(context)! * 0.01),
                      width: double.infinity,
                      height: height(context)! * 0.07,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kBorderRadius + 12),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          boxShadow: const [
                            BoxShadow(spreadRadius: 0.3, blurRadius: 0.2)
                          ]),
                      child: Center(
                        child: Text(
                          "Option $index",
                          style: themeTextStyle(
                            context: context,
                            fsize: klargeFont(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
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
                  onClicked: () {},
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
