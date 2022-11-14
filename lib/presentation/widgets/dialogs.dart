import 'package:datacoup/export.dart';

passwordResetDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.9),
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
            title: SizedBox(
          height: 160,
          width: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.greenAccent),
                  color: Colors.greenAccent.shade100,
                ),
                child: const Icon(Icons.done, color: Colors.greenAccent)),
            const SizedBox(height: 10),
            const Text("You have successfully reset your password !",
                style: TextStyle(
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  fixedSize: const Size(50, 10),
                  backgroundColor: Colors.greenAccent),
              onPressed: () {
                Get.offAll(() => Login());
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: AssetConst.RALEWAY_FONT,
                ),
              ),
            ),
          ]),
        )),
      );
    },
  );
}
