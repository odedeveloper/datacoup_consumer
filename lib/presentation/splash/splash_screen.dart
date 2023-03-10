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
    SizeConfig().init(context);
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height(context)! * 0.8,
              width: width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.w),
                    bottomRight: Radius.circular(200.w)),
                color: greyColor,
              ),
              child: FittedBox(
                fit: BoxFit.none,
                child: CacheImageWidget(
                  fromAsset: true,
                  imageUrl: AssetConst.LOGO_PNG,
                  imgheight: 200.h,
                  imgwidth: 200.h,
                  cFit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Spacer(),
            Text(
              StringConst.APP_NAME,
              style: themeTextStyle(
                context: context,
                tColor: deepOrangeColor,
                fsize: 30.h,
                letterSpacing: 1,
                fontFamily: AssetConst.QUICKSAND_FONT,
                fweight: FontWeight.w900,
              ),
            ),
            Text(
              StringConst.SPLASH_TEXT,
              style: themeTextStyle(
                context: context,
                tColor: deepOrangeColor,
                fsize: 14,
                letterSpacing: 1,
                fontStyle: FontStyle.italic,
                fontFamily: AssetConst.QUICKSAND_FONT,
                fweight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
