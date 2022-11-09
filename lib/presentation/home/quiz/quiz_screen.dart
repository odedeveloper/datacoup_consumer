import 'package:datacoup/export.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Quiz",
              style: themeTextStyle(context: context, fweight: FontWeight.bold),
            ),
            toolbarHeight: height(context)! * 0.04,
            bottom: TabBar(
              padding: EdgeInsets.zero,
              labelStyle: themeTextStyle(context: context),
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: deepOrangeColor,
              tabs: const [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Statistics",
                )
              ],
            )),
        body: const TabBarView(
          children: [
            AllQuizWidget(),
            QuizStatisticsWidget(),
          ],
        ),
      ),
    );
  }
}
