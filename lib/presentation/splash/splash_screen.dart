import 'package:datacoup/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashcontroller = Get.find<SplachController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CacheImageWidget(
              fromAsset: true,
              imageUrl: AssetConst.LOGO_PNG,
              imgheight: height(context)! * 0.12,
              imgwidth: width(context)! * 0.25,
            ),
            const SizedBox(height: 25),
            Text(
              StringConst.SPLASH_TEXT,
              style: themeTextStyle(
                context: context,
                fsize: ksmallFont(context),
                letterSpacing: 1,
                fontStyle: FontStyle.italic,
                fontFamily: AssetConst.RALEWAY_FONT,
                fweight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
