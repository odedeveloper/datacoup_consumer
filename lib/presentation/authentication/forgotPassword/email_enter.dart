import 'package:datacoup/export.dart';

class ByEmail extends StatelessWidget {
  const ByEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Email".tr,
            style: TextStyle(
                letterSpacing: 0.9,
                fontFamily: AssetConst.RALEWAY_FONT,
                fontSize: 15,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        Container(
            alignment: Alignment.center,
            height: 30 * SizeConfig().heightScale,
            child: GetBuilder<ForgotPasswordController>(builder: (controller) {
              return TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                scrollPadding: EdgeInsets.zero,
                style: TextStyle(
                  letterSpacing: 0.9,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontFamily: AssetConst.RALEWAY_FONT,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 18 * SizeConfig().heightScale),
                ),
              );
            })),
      ],
    );
  }
}
