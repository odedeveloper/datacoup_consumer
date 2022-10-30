import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:datacoup/export.dart';

class CustomLoginTextField extends StatelessWidget {
  CustomLoginTextField(
      {super.key,
      this.controller,
      this.onEyeTap,
      this.showEye = false,
      this.showData = false,
      this.forPhoneNumber = false,
      this.label});
  final TextEditingController? controller;
  final String? label;
  final bool? showEye;
  final bool? forPhoneNumber;
  final bool? showData;
  final VoidCallback? onEyeTap;

  final statecontroller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label!,
            style: themeTextStyle(
              context: context,
              letterSpacing: 0.9,
              fontFamily: AssetConst.ralewayFont,
              tColor: Colors.grey[400],
              fweight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              forPhoneNumber!
                  ? Expanded(
                      child: Obx(
                      () => InputDecorator(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15),
                        ),
                        child: InkWell(
                          onTap: () => _showCountryPicker(context),
                          child: Center(
                            child: Text(
                              "+${statecontroller.selectedCountryCode.value}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.secondary,
                                fontFamily: AssetConst.quickSand,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                  : const SizedBox.shrink(), // contry code picker
              forPhoneNumber!
                  ? const SizedBox(width: 15)
                  : const SizedBox.shrink(),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: controller,
                  obscureText: showData!,
                  style: themeTextStyle(
                    context: context,
                    letterSpacing: 0.9,
                    fweight: FontWeight.w500,
                    fontFamily: AssetConst.ralewayFont,
                    fontStyle: FontStyle.normal,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 15),
                    suffixIcon: showEye!
                        ? IconButton(
                            onPressed: onEyeTap,
                            icon: Icon(
                              statecontroller.showPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility_rounded,
                              color: darkGreyColor,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
          log('Select country: ${country.phoneCode}');
          statecontroller.updateCountryCode(country.phoneCode);
        });
  }
}
