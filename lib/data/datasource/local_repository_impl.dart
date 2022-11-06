import 'package:datacoup/export.dart';

const _prefDarkTheme = "THEME_DARK";
const _idToken = "idToken";

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    GetStorage deviceStorage = GetStorage();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    deviceStorage.erase();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_idToken);
  }

  @override
  Future<bool?> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_prefDarkTheme);
  }

  @override
  Future<void> saveDarkMode(bool? darkmode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_prefDarkTheme, darkmode!);
  }
}
