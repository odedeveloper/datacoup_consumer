import 'package:datacoup/export.dart';

class LogoContainer extends StatelessWidget {
  final String title;
  final double height;
  const LogoContainer({Key? key, required this.title, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height * SizeConfig().heightScale,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30 * SizeConfig().heightScale),
            Image.asset(AssetConst.LOGO_PNG,
                height: 80 * SizeConfig().heightScale),
            SizedBox(height: 30 * SizeConfig().heightScale),
            Text("DATACOUP NEWS",
                style: themeTextStyle(
                  context: context,
                  fweight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fsize: kextraLargeFont(context),
                )),
            SizedBox(height: 15 * SizeConfig().heightScale),
            Text(
              title,
              style: themeTextStyle(
                context: context,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ));
  }
}
