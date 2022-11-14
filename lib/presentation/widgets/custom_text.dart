import 'package:datacoup/export.dart';

class CustomText extends StatelessWidget {
  final String label;
  String fontFamily;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign alignment;
  CustomText(this.label,
      {this.fontFamily = AssetConst.QUICKSAND_FONT,
      this.color = blackColor,
      this.fontSize = 12,
      this.fontWeight = FontWeight.normal,
      this.alignment = TextAlign.start,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        textAlign: alignment,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ));
  }
}
