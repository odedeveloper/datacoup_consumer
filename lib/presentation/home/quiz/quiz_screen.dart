import 'package:datacoup/export.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Quiz",
          style: themeTextStyle(
            context: context,
            fweight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
