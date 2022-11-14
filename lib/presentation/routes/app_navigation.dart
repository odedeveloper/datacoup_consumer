import 'package:datacoup/export.dart';

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
      page: () => const SplashScreen(),
      bindings: [MainBinding(), SplashBinding(), AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => Login(),
      bindings: [MainBinding(), LoginBinding(), AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUp(),
      bindings: [MainBinding(), SignupBinding(), AuthenticationBinding()],
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
    // GetPage(
    //   name: AppRoutes.quizScreen,
    //   page: () => const QuizScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.allQuizScreen,
    //   page: () => const AllQuizWidget(),
    //   binding: QuizBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.editProfile,
    //   page: () => const EditProfileScreen(),
    //   // bindings: [MainBinding(), HomeBinding()],
    // ),
  ];
}
