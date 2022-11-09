import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/widgets/quiz_play_widget.dart';

class AllQuizWidget extends StatelessWidget {
  const AllQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: 8,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 20),
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: InkWell(
          onTap: () => Get.to(() => const QuizPlayWidget()),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(kBorderRadius),
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 0.8,
                      color: Colors.black45,
                      offset: Offset(0.5, 0.7))
                ]),
            child: Stack(
              children: [
                const WaveCard(),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    "Quiz Title",
                    style: themeTextStyle(
                      context: context,
                      fsize: klargeFont(context),
                      tColor: blackColor,
                      fweight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    "Quiz Description",
                    style: themeTextStyle(
                      context: context,
                      fsize: klargeFont(context),
                      tColor: blackColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 20,
                  child: Text(
                    "Quiz Type",
                    style: themeTextStyle(
                      context: context,
                      fsize: klargeFont(context),
                      tColor: blackColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: kextraLargeFont(context),
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
