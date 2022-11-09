import 'package:datacoup/export.dart';

class QuizProgressWidget extends StatelessWidget {
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

  Widget tick(bool isChecked, int index) {
    return isChecked
        ? Material(
            elevation: 2.0,
            color: Colors.blue,
            shape: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "${index + 1}",
                ),
              ),
            ))
        // const Icon(
        //     Icons.check_circle,
        //     color: Colors.blue,
        //   )
        : const Icon(
            Icons.radio_button_unchecked,
            color: Colors.blue,
          );
  }

  Widget tick1({int? index}) {
    if (index == ticks! - 1) {
      return ticks! > index!
          ? Row(
              children: [
                tick(true, index),
                spacer(),
              ],
            )
          : tick(false, index);
    } else {
      return ticks! > index!
          ? Row(
              children: [
                tick(true, index),
                spacer(),
                line(),
              ],
            )
          : tick(false, index);
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
