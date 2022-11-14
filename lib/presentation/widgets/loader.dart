import 'package:datacoup/export.dart';

class Loader extends StatelessWidget {
  final String text;
  final bool isLoading;
  const Loader({Key? key, required this.text, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: SizeConfig().deviceHeight,
            color: Colors.black.withOpacity(0.9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AssetConst.LOGO_GIF),
                Container(
                  padding: const EdgeInsets.only(top: 130),
                  child: Text(text,
                      style: const TextStyle(
                        color: whiteColor,
                        fontFamily: AssetConst.QUICKSAND_FONT,
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                      )),
                )
              ],
            ),
          )
        : Container();
  }
}
