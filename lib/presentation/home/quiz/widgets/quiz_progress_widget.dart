import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_controller.dart';

class QuizProgressWidget extends GetWidget<QuizController> {
  final int? ticks;

  const QuizProgressWidget({super.key, this.ticks});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          ticks!,
          (index) => tick1(index: index),
        ),
      ),
    );
  }

  Widget tick(int index) {
    return Obx(() {
      bool res = controller.progressList.contains(index);
      return res
          ? Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.25), // border color
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2), // border width
                child: Container(
                    // or ClipRRect if you need to clip the content
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // inner circle color
                    ),
                    child: Center(
                      child: Text(
                        "$index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ) // inner content
                    ),
              ),
            )
          : Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.25), // border color
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2), // border width
                child: Container(
                    // or ClipRRect if you need to clip the content
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // inner circle color
                    ),
                    child: Center(
                      child: Text(
                        "$index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ) // inner content
                    ),
              ),
            );
    });
  }

  Widget tick1({int? index}) {
    if (index == ticks! - 1) {
      return ticks! > index!
          ? Row(
              children: [
                tick(index),
                spacer(),
              ],
            )
          : tick(index);
    } else {
      return ticks! > index!
          ? Row(
              children: [
                tick(index),
                spacer(),
                line(),
              ],
            )
          : tick(index);
    }
  }

  Widget spacer() {
    return Container(
      width: 5.0,
    );
  }

  Widget line() {
    return Container(
      color: deepOrangeColor,
      height: 5.0,
      width: 50.0,
    );
  }
}
