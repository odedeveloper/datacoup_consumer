// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:datacoup/config/size_config.dart';
// import 'package:datacoup/constants/color_constants.dart';
// import 'package:datacoup/constants/image_contants.dart';
// import 'package:datacoup/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:get/get_utils/get_utils.dart';

// class SignByMobile extends StatelessWidget {
//   const SignByMobile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("phoneNumber".tr,
//             style: TextStyle(
//                 letterSpacing: 0.9,
//                 fontFamily: AssetConst.RALEWAY_FONT,
//                 fontSize: 15,
//                 color: Colors.grey[400],
//                 fontWeight: FontWeight.w500)),
//         GetBuilder<LoginController>(builder: (_controller) {
//           return Container(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Container(
//                   alignment: Alignment.topCenter,
//                   decoration: const BoxDecoration(
//                       border: Border(
//                     bottom: BorderSide(
//                       color: Colors.grey,
//                       width: 1.0,
//                     ),
//                   )),
//                   child: CountryCodePicker(
//                     backgroundColor: Colors.grey.shade600,
//                     dialogSize: const Size(320, 500),
//                     padding: EdgeInsets.zero,
//                     textStyle: const TextStyle(
//                         fontSize: 15,
//                         color: darkBlueGreyColor,
//                         fontFamily: AssetConst.QUICKSAND_FONT,
//                         fontWeight: FontWeight.w500),
//                     onChanged: (value) {
//                       _controller.updateCountryCode(value.dialCode!);
//                     },
//                     showFlagMain: false,
//                     initialSelection: _controller.countryCode,
//                   ),
//                 ),
//                 Container(
//                   width: 255 * SizeConfig().widthScale,
//                   // height:20,
//                   alignment: Alignment.bottomCenter,
//                   padding: const EdgeInsets.only(left: 20),
//                   child: TextFormField(
//                     controller: _controller.mobileController,
//                     autofocus: false,
//                     // maxLength: 10,
//                     keyboardType: TextInputType.number,
//                     scrollPadding: EdgeInsets.zero,
//                     style: TextStyle(
//                       letterSpacing: 0.9,
//                       color: Colors.grey.shade700,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: AssetConst.RALEWAY_FONT,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 18,
//                     ),
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.only(bottom: 5 * SizeConfig().heightScale),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
