import 'package:datacoup/export.dart';

class AccountDeletedScreen extends StatelessWidget {
  const AccountDeletedScreen({super.key});

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
              AssetConst.CHECKED,
              height: 200.h,
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
            "Account deleted",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 20,
              fweight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
            "We have now permanentaly deleted your account.",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 14,
              fweight: FontWeight.w800,
            ),
          ),
          Text(
            "We are very sorry to see you leave.",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 14,
              fweight: FontWeight.w800,
            ),
          ),
          Text(
            "You are always welcome to join Datacoup again!",
            style: themeTextStyle(
              context: context,
              tColor: Theme.of(context).primaryColor,
              fsize: 14,
              fweight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 50.h,
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
                child: Text("GOT IT",
                    style: themeTextStyle(
                        context: context, fsize: 14, tColor: whiteColor)),
              )),
        ],
      )),
    );
  }
}
