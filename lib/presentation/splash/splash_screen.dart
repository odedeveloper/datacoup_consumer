import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/utils/constants/responsive.dart';

class SplashScreen extends GetWidget<SplachController> {
  SplashScreen({super.key});

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
              imageUrl: AssetConst.logoPng,
              imgheight: height(context)! * 0.12,
              imgwidth: width(context)! * 0.25,
            ),
            const SizedBox(height: 25),
            Text(
              splashTitle,
              style: themeTextStyle(
                context: context,
                fsize: ksmallFont(context),
                letterSpacing: 1,
                fontStyle: FontStyle.italic,
                fontFamily: AssetConst.ralewayFont,
                fweight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
