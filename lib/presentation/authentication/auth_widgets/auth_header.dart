// import 'package:datacoup/export.dart';

// class AuthenticationHeader extends StatelessWidget {
//   final bool fromLogin;
//   const AuthenticationHeader({Key? key, this.fromLogin = true})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CacheImageWidget(
//           fromAsset: true,
//           imageUrl: AssetConst.LOGO_PNG,
//           imgheight: height(context)! * 0.10,
//           imgwidth: width(context)! * 0.22,
//         ),
//         const SizedBox(height: 25),
//         Text(
//           StringConst.name.toUpperCase(),
//           style: themeTextStyle(
//             context: context,
//             fweight: FontWeight.bold,
//             fontFamily: AssetConst.RALEWAY_FONT,
//             fsize: kmaxExtraLargeFont(context)! + 4,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           fromLogin ? "$appDesc !" : createAccountDesc,
//           style: themeTextStyle(
//             context: context,
//             fontFamily: AssetConst.RALEWAY_FONT,
//             fontStyle: FontStyle.italic,
//             tColor: Theme.of(context).colorScheme.secondary,
//             fweight: FontWeight.w700,
//             letterSpacing: 1,
//           ),
//         ),
//       ],
//     );
//   }
// }
