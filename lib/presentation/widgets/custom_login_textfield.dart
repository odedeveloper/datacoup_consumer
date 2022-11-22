import 'package:datacoup/export.dart';

class CustomLoginTextField extends StatelessWidget {
  const CustomLoginTextField(
      {super.key,
      this.controller,
      this.onEyeTap,
      this.showEye = false,
      this.showData = false,
      // this.signupController,
      // this.loginController,
      this.enabledEdit = true,
      this.onChanged,
      this.forPhoneNumber = false,
      this.label});
  final TextEditingController? controller;
  // final LoginController? loginController;
  // final SignUpController? signupController;
  final Function(String)? onChanged;

  final String? label;
  final bool? showEye;
  final bool? enabledEdit;
  final bool? forPhoneNumber;
  final bool? showData;
  final VoidCallback? onEyeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: themeTextStyle(
            context: context,
            letterSpacing: 0.9,
            fontFamily: AssetConst.RALEWAY_FONT,
            tColor: Theme.of(context).primaryColor.withOpacity(0.6),
            fweight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            // forPhoneNumber!
            //     ? Expanded(
            //         child: Obx(
            //         () => InputDecorator(
            //           decoration: InputDecoration(
            //             contentPadding: const EdgeInsets.only(top: 15),
            //             enabledBorder: UnderlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Theme.of(context).primaryColor),
            //             ),
            //             focusedBorder: UnderlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Theme.of(context).primaryColor),
            //             ),
            //             disabledBorder: UnderlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Theme.of(context).primaryColor),
            //             ),
            //             border: UnderlineInputBorder(
            //               borderSide:
            //                   BorderSide(color: Theme.of(context).primaryColor),
            //             ),
            //           ),
            //           child: InkWell(
            //             onTap: () => _showCountryPicker(context),
            //             child: Center(
            //               child: Text(
            //                 loginController != null
            //                     ? "+${loginController!.selectedCountryCode.value}"
            //                     : "+${signupController!.selectedCountryCode.value}",
            //                 style: TextStyle(
            //                   fontSize: 15,
            //                   color: Theme.of(context).colorScheme.secondary,
            //                   fontFamily: AssetConst.QUICKSAND_FONT,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ))
            //     : const SizedBox.shrink(), // contry code picker
            // forPhoneNumber!
            //     ? const SizedBox(width: 15)
            //     : const SizedBox.shrink(),
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: controller,
                obscureText: showData!,
                enabled: enabledEdit!,
                style: themeTextStyle(
                  context: context,
                  letterSpacing: 0.9,
                  fweight: FontWeight.w500,
                  fontFamily: AssetConst.RALEWAY_FONT,
                  fontStyle: FontStyle.normal,
                ),
                onChanged: onChanged,
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.only(top: 15),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  ),
                  // suffixIcon: showEye!
                  //     ? IconButton(
                  //         onPressed: onEyeTap,
                  //         icon: Icon(
                  //           loginController!.showPassword.value
                  //               ? Icons.visibility_off
                  //               : Icons.visibility_rounded,
                  //           color: darkGreyColor,
                  //         ),
                  //       )
                  //     : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _showCountryPicker(BuildContext context) {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textStyle: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.secondary),
          bottomSheetHeight: 500, // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.secondary),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          // log('Select country: ${country.phoneCode}');
          final controller = Get.find<HomeController>();

          controller.updateCountryCode(country.phoneCode);
        });
  }
}
