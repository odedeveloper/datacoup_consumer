import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:datacoup/amplifyconfiguration.dart';
import 'package:datacoup/languages.dart';
import 'package:global_configuration/global_configuration.dart';

import 'export.dart';

Future<void> main() async {
  await GetStorage.init();
  GlobalConfiguration().loadFromMap(appSettingsDev);
  await configureAmplify();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  // AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

  Amplify.addPlugins([AmplifyAuthCognito()]);
  try {
    await Amplify.configure(amplifyconfig);
    log('amplify configured -------');
  } catch (e) {
    log('Amplify is configured.');
  }
}



class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, Locale> _locales = {
    "English": const Locale('en', 'US'),
    "Hindi": const Locale('hi', 'IN')
  };

  initializeLanguage() {
    bool isPresent = GetStorage().hasData("Language");
    if (!isPresent) {
      return Get.deviceLocale;
    } else {
      String value = GetStorage().read("Language");
      Locale? locale = _locales[value];
      return locale!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DataCoup News',
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: MainBinding(),
      locale: initializeLanguage(),
      translations: Languages(),
      localizationsDelegates: const [CountryLocalizations.delegate],
    );
  }
}
