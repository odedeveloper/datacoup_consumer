import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/widgets/quiz_play_widget.dart';

class AllQuizWidget extends StatefulWidget {
  const AllQuizWidget({super.key});

  @override
  State<AllQuizWidget> createState() => _AllQuizWidgetState();
}

class _AllQuizWidgetState extends State<AllQuizWidget> {
  final homeController = Get.find<HomeController>();
  final quizController = Get.find<QuizController>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await quizController.getAllQuiz(odenId: "", topic: "");
    quizController.quizListLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => quizController.quizListLoader.value
            ? ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: 8,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 15, bottom: 50),
                itemBuilder: (context, index) => const ShimmerBox(
                  radius: kBorderRadius,
                  height: 100,
                  width: double.infinity,
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: quizController.quizModel!.items!.length,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 15, bottom: 50),
                itemBuilder: (context, index) {
                  final data = quizController.quizModel!.items![index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    child: Card(
                      elevation: 10.0,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      child: ListTile(
                        onTap: () =>
                            Get.to(() => QuizPlayWidget(quizItem: data)),
                        title: Text(
                          data.topic!,
                          style: themeTextStyle(
                            context: context,
                            fweight: FontWeight.bold,
                            fsize: klargeFont(context),
                          ),
                        ),
                        subtitle: Text(
                          "Time Limit ${data.timeLimit!} min",
                          style: themeTextStyle(
                            context: context,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: kextraLargeFont(context),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
