import 'package:datacoup/export.dart';

class ProfileSucess extends StatelessWidget {
  const ProfileSucess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
          ),
          Center(
            child: Image.asset(
              AssetConst.SUCCESS,
              height: 250.h,
            ),
          ),
          SizedBox(
            height: 200.h,
          ),
          Text(
            "Account created!",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 20,
              fweight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Thanks for signing up!",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 14,
              fweight: FontWeight.w800,
            ),
          ),
          Text(
            "You can now start exploring data-privacy content.",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 14,
              fweight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          TextButton(
              onPressed: () {
                Get.offAll(() => Login());
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(deepOrangeColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.red)
                  ))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Return to Sign In",
                    style: themeTextStyle(
                        context: context, fsize: 14, tColor: whiteColor)),
              )),
        ],
      )),
    );
  }
}
