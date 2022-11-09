import 'package:datacoup/export.dart';

class QuizProgressWidget extends StatelessWidget {
  final int? ticks;

  const QuizProgressWidget({super.key, this.ticks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) => tickBody(),
    );
  }

  Widget tickBody() {
    return Row(
      children: [
        tick1(),
        spacer(),
        line(),
        spacer(),
      ],
    );
  }

  Widget tick(bool isChecked) {
    return isChecked
        ? const Icon(
            Icons.check_circle,
            color: Colors.blue,
          )
        : const Icon(
            Icons.radio_button_unchecked,
            color: Colors.blue,
          );
  }

  Widget tick1() {
    return ticks! > 0 ? tick(true) : tick(false);
  }

  Widget tick2() {
    return ticks! > 1 ? tick(true) : tick(false);
  }

  Widget tick3() {
    return ticks! > 2 ? tick(true) : tick(false);
  }

  Widget tick4() {
    return ticks! > 3 ? tick(true) : tick(false);
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
