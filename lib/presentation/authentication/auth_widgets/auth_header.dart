import 'package:datacoup/export.dart';

class AuthenticationHeader extends StatelessWidget {
  final bool fromLogin;
  const AuthenticationHeader({Key? key, this.fromLogin = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CacheImageWidget(
          fromAsset: true,
          imageUrl: AssetConst.logoPng,
          imgheight: height(context)! * 0.10,
          imgwidth: width(context)! * 0.22,
        ),
        const SizedBox(height: 25),
        Text(
          appName.toUpperCase(),
          style: themeTextStyle(
            context: context,
            fweight: FontWeight.bold,
            fontFamily: AssetConst.ralewayFont,
            fsize: kmaxExtraLargeFont(context)! + 4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          fromLogin ? "$appDesc !" : createAccountDesc,
          style: themeTextStyle(
            context: context,
            fontFamily: AssetConst.ralewayFont,
            fontStyle: FontStyle.italic,
            fweight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
