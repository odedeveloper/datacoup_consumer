import 'export.dart';

Future<void> main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      // themeMode: ThemeMode.dark,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: MainBinding(),
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
    );
  }
}
