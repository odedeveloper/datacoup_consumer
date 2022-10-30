import 'package:datacoup/export.dart';

class RoundedElevatedButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onClicked;
  const RoundedElevatedButton({Key? key, this.onClicked, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(redOpacityColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: Text(
          title!,
          style: themeTextStyle(
            context: context,
            tColor: whiteColor,
            fsize: klargeFont(context),
            fweight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
