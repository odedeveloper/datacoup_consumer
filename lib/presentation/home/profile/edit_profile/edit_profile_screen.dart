// import 'package:csc_picker/csc_picker.dart';
import 'package:datacoup/export.dart';
// import 'package:datacoup/presentation/widgets/drop_down_widget.dart';

// class EditProfileScreen extends GetWidget<> {
//   const EditProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         iconTheme:
//             IconThemeData(color: Theme.of(context).colorScheme.secondary),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       createAccountDesc,
//                       style: themeTextStyle(
//                         context: context,
//                         fweight: FontWeight.bold,
//                         fontFamily: AssetConst.ralewayFont,
//                         fsize: kmaxExtraLargeFont(context)! + 4,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   CircleAvatar(
//                     radius: width(context)! * 0.2,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     selectProfilePhoto,
//                     style: themeTextStyle(
//                       context: context,
//                       tColor: redOpacityColor,
//                       fweight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   CustomLoginTextField(
//                     controller: controller.fullNameTextContoller,
//                     label: "Full Name",
//                   ),
//                   const SizedBox(height: 10),
//                   CustomLoginTextField(
//                     controller: controller.emailTextContoller,
//                     label: "Email Address",
//                   ),
//                   const SizedBox(height: 10),
//                   CustomLoginTextField(
//                     controller: controller.phoneNumberTextContoller,
//                     label: "Phone Number",
//                   ),
//                   const SizedBox(height: 10),
//                   const LightLabelWidget(label: "Gender"),
//                   Obx(
//                     () => DropDownWidget(
//                       labelText: ' Gender',
//                       hintText: controller.selectedreturnGender.value == ""
//                           ? 'Select Gender'
//                           : controller.selectedreturnGender.value,
//                       dropMenuList: controller.genderlist,
//                       selectedReturnValue: (value) {
//                         controller.selectedreturnGender(value);
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const LightLabelWidget(label: "Location"),
//                   const SizedBox(height: 10),
//                   Obx(
//                     () => Container(
//                       alignment: Alignment.center,
//                       height: 52,
//                       child: CSCPicker(
//                           showStates: true,
//                           showCities: false,
//                           flagState: CountryFlag.ENABLE,
//                           dropdownDecoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1)),
//                           disabledDropdownDecoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1)),
//                           countrySearchPlaceholder: "Search Country",
//                           stateSearchPlaceholder: "Search State",
//                           countryDropdownLabel: " Select Country",
//                           stateDropdownLabel: "Select State",
//                           cityDropdownLabel: "State",
//                           selectedItemStyle: TextStyle(
//                             color: Theme.of(context).colorScheme.secondary,
//                             fontSize: 14,
//                           ),
//                           dropdownHeadingStyle: TextStyle(
//                               color: Theme.of(context).colorScheme.secondary,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                           dropdownItemStyle: TextStyle(
//                             color: Theme.of(context).colorScheme.secondary,
//                             fontSize: 14,
//                           ),
//                           dropdownDialogRadius: 10.0,
//                           searchBarRadius: 10.0,
//                           currentCountry: controller.selectedCountry.value,
//                           currentState: controller.selectedstate.value,
//                           onCountryChanged: (value) {
//                             String country = value;
//                             controller.updateCountry(country);
//                           },
//                           onStateChanged: (value) {
//                             String state = value ?? "";
//                             controller.updateState(state);
//                           },
//                           onCityChanged: (value) {}),
//                     ),
//                   ),
//                   Obx(
//                     () => Align(
//                       alignment: Alignment.topLeft,
//                       child: CustomLoginTextField(
//                         controller: controller.passwordTextContoller,
//                         label: "Password",
//                         showEye: true,
//                         showData: controller.showPassword.value,
//                         onEyeTap: () {
//                           controller.updateShowPassword(
//                               !controller.showPassword.value);
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Obx(
//                     () => Align(
//                       alignment: Alignment.topLeft,
//                       child: CustomLoginTextField(
//                         controller: controller.confirmpasswordTextContoller,
//                         label: "Confirm Password",
//                         showEye: true,
//                         showData: controller.showPassword.value,
//                         onEyeTap: () {
//                           controller.updateShowPassword(
//                               !controller.showPassword.value);
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Obx(
//                       () => controller.loginState.value == LoginState.loading
//                           ? const Center(child: CircularProgressIndicator())
//                           : RoundedElevatedButton(
//                               title: "CONTINUE",
//                               onClicked: () {},
//                             ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LightLabelWidget extends StatelessWidget {
  final String? label;
  final double? fontsize;
  final TextAlign? textAlign;
  const LightLabelWidget(
      {Key? key, required this.label, this.textAlign, this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          label!,
          textAlign: textAlign,
          style: themeTextStyle(
            context: context,
            letterSpacing: 0.9,
            fsize: fontsize,
            fontFamily: AssetConst.ralewayFont,
            tColor: Colors.grey[400],
            fweight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
