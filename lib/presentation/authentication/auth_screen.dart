import 'package:datacoup/export.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: Container(
              child: SingleChildScrollView(
                  child: Column(children: [
        Container(
            height: 350 * SizeConfig().heightScale,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30 * SizeConfig().heightScale),
                Image.asset(AssetConst.LOGO_PNG,
                    height: 80 * SizeConfig().heightScale),
                SizedBox(height: 50 * SizeConfig().heightScale),
                Text("DATACOUP",
                    style: TextStyle(
                        letterSpacing: 0.9,
                        fontSize: 18,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        SizedBox(height: 30 * SizeConfig().heightScale),
        Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Email",
                style: TextStyle(
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.RALEWAY_FONT,
                    fontSize: 15,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500)),
            Container(
              alignment: Alignment.center,
              height: 30 * SizeConfig().heightScale,
              child: GetBuilder<LoginController>(
                  builder: (controller) => (TextFormField(
                        controller: controller.usernameController,
                        scrollPadding: EdgeInsets.zero,
                        style: TextStyle(
                          letterSpacing: 0.9,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          height: 1.0,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 18 * SizeConfig().heightScale),
                        ),
                      ))),
            ),
            SizedBox(height: 25 * SizeConfig().heightScale),
            Text("Password",
                style: TextStyle(
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.RALEWAY_FONT,
                    fontSize: 15,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500)),
            Container(
                alignment: Alignment.center,
                height: 30 * SizeConfig().heightScale,
                child: GetBuilder<LoginController>(
                    builder: (controller) => (TextFormField(
                          obscureText: true,
                          controller: controller.passwordController,
                          scrollPadding: EdgeInsets.zero,
                          style: TextStyle(
                            color: darkGreyColor,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w500,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            height: 1.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 18),
                          ),
                        )))),
            SizedBox(height: 30 * SizeConfig().heightScale),
            TextButton(
                onPressed: () {
                  Get.to(() => VerifyOtp(
                        isEmail: true,
                      ));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(deepOrangeColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(StringConst.CONTINUE,
                        style: TextStyle(
                            letterSpacing: 0.9,
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: AssetConst.RALEWAY_FONT)),
                  ],
                )),
            SizedBox(height: 30 * SizeConfig().heightScale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(StringConst.DONT_HAVE_AN_ACCOUNT,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: AssetConst.RALEWAY_FONT,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 10 * SizeConfig().heightScale),
            TextButton(
                onPressed: () {
                  Get.to(() => SignUp());
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(deepOrangeColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(StringConst.SIGN_UP,
                        style: TextStyle(
                            letterSpacing: 0.9,
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: AssetConst.RALEWAY_FONT)),
                  ],
                )),
          ]),
        ))
      ])))),
    );
  }
}
