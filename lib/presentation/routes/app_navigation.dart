import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/signup/verify_otp_screen.dart';
import 'package:datacoup/presentation/news/news_binding.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyOtp = "/verifyOtp";
  static const String home = "/home";
  static const String editProfile = "/editProfile";
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      bindings: [MainBinding(), SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      bindings: [MainBinding(), LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      bindings: [MainBinding(), SignupBinding()],
    ),
    GetPage(
      name: AppRoutes.verifyOtp,
      page: () => const VerifyOTPScreen(),
      bindings: [MainBinding(), SignupBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      bindings: [MainBinding(), HomeBinding(), NewsBindings()],
    ),

    // GetPage(
    //   name: AppRoutes.editProfile,
    //   page: () => const EditProfileScreen(),
    //   // bindings: [MainBinding(), HomeBinding()],
    // ),
  ];
}
