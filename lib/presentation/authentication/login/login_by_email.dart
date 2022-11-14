// import 'package:datacoup/config/size_config.dart';
// import 'package:datacoup/constants/image_contants.dart';
// import 'package:datacoup/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:get/get_utils/get_utils.dart';

// class SignByEmail extends StatelessWidget {
//   const SignByEmail({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("email".tr,
//             style: TextStyle(
//                 letterSpacing: 0.9,
//                 fontFamily: AssetConst.RALEWAY_FONT,
//                 fontSize: 15,
//                 color: Colors.grey[400],
//                 fontWeight: FontWeight.w500)),
//         const SizedBox(height: 10),
//         Container(
//             alignment: Alignment.center,
//             height: 35,
//             child: GetBuilder<LoginController>(
//                 init: LoginController(),
//                 builder: (_controller) {
//                   return TextFormField(
//                     textCapitalization: TextCapitalization.none,
//                     controller: _controller.emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     scrollPadding: EdgeInsets.zero,
//                     style: TextStyle(
//                       letterSpacing: 0.9,
//                       color: Colors.grey.shade700,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: AssetConst.RALEWAY_FONT,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 16,
//                     ),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                           bottom: 18 * SizeConfig().heightScale),
//                     ),
//                   );
//                 })),
//       ],
//     );
//   }
// }
