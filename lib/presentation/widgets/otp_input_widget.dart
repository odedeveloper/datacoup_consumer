import 'package:datacoup/export.dart';

class OtpTextBix extends StatelessWidget {
  final ValueChanged<String> onOtpChange;
  OtpTextBix({required this.onOtpChange, Key? key}) : super(key: key);

  final List<String> otp = [' ', ' ', ' ', ' ', ' ', ' '];

  onChangeOtp(int index, String value) {
    if (value != '') {
      otp[index] = value;
    }
    returnOtp();
  }

  returnOtp() {
    String finalOtp = otp.fold(
        '', (previousValue, element) => previousValue.toString() + element);
    onOtpChange(finalOtp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          6,
          (index) => Padding(
                padding: const EdgeInsets.all(4),
                child: OtpInputSingle(
                  index: index,
                  autoFocus: index == 0 ? true : false,
                  callback: onChangeOtp,
                ),
              )),
    );
  }
}

class OtpInputSingle extends StatelessWidget {
  // final TextEditingController controller;
  final bool autoFocus;
  final int index;
  final Function callback;
  const OtpInputSingle(
      {required this.index,
      required this.autoFocus,
      required this.callback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.2,
              spreadRadius: 0.1,
            )
          ]),
      height: 55,
      width: 45,
      alignment: Alignment.center,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: AssetConst.QUICKSAND_FONT,
          color: Theme.of(context).colorScheme.secondary,
        ),
        // controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            callback(index, value);
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
