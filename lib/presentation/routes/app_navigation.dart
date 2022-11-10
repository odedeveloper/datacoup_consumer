import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/signup/verify_otp_screen.dart';
import 'package:datacoup/presentation/home/news/news_binding.dart';
import 'package:datacoup/presentation/home/quiz/quiz_binding.dart';
import 'package:datacoup/presentation/videos/videos_screen.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyOtp = "/verifyOtp";
  static const String home = "/home";
  static const String editProfile = "/editProfile";
  static const String videoScreen = "/videoScreen";
  static const String quizScreen = "/QuizScreen";
  static const String allQuizScreen = "/allQuizScreen";
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
      bindings: [MainBinding(), HomeBinding(), NewsBindings(), QuizBinding()],
    ),
    GetPage(
      name: AppRoutes.videoScreen,
      page: () => const VideoScreen(),
    ),
    GetPage(
      name: AppRoutes.quizScreen,
      page: () => const QuizScreen(),
    ),
    GetPage(
      name: AppRoutes.allQuizScreen,
      page: () => const AllQuizWidget(),
      binding: QuizBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.editProfile,
    //   page: () => const EditProfileScreen(),
    //   // bindings: [MainBinding(), HomeBinding()],
    // ),
  ];
}
