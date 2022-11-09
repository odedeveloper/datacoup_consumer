import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/widgets/quiz_play_widget.dart';

class AllQuizWidget extends StatelessWidget {
  const AllQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 8,
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 50),
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(kBorderRadius),
          child: Card(
            elevation: 10.0,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: ListTile(
              onTap: () => Get.to(() => const QuizPlayWidget()),
              title: Text(
                "Quiz Title",
                style: themeTextStyle(
                  context: context,
                  fweight: FontWeight.bold,
                  fsize: klargeFont(context),
                ),
              ),
              subtitle: Text(
                "Quiz Description",
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

          // InkWell(
          //   onTap: () => Get.to(() => const QuizPlayWidget()),
          //   child: SizedBox(
          //     height: height(context)! * 0.15,
          //     width: double.infinity,
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           top: 20,
          //           left: 20,
          // child: Text(
          //   "Quiz Title",
          //   style: themeTextStyle(
          //     context: context,
          //     fsize: klargeFont(context),
          //     fweight: FontWeight.bold,
          //   ),
          // ),
          //         ),
          //         Positioned(
          //           top: 50,
          //           left: 20,
          // child: Text(
          //   "Quiz Description",
          //   style: themeTextStyle(
          //     context: context,
          //     fsize: klargeFont(context),
          //   ),
          // ),
          //         ),
          //         Positioned(
          //           top: 90,
          //           left: 20,
          //           child: Text(
          //             "Quiz Type",
          //             style: themeTextStyle(
          //               context: context,
          //               fsize: klargeFont(context),
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           right: 10,
          //           bottom: 20,
          // child: Icon(
          //   Icons.arrow_forward_ios_rounded,
          //   size: kextraLargeFont(context),
          // ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
