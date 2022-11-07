import 'package:datacoup/export.dart';

const _prefDarkTheme = "THEME_DARK";
const _idRefreshToken = "idRfreshToken";
const _idIdToken = "idIdToken";

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    GetStorage deviceStorage = GetStorage();
    deviceStorage.erase();
  }

  // @override
  // Future<String?> getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getString(_idToken);
  // }

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

  @override
  Future<void> saveRefreshToken({String? refToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_idRefreshToken, refToken!);
  }

  @override
  Future<String?> getRefreshToken({String? refToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_idRefreshToken);
  }

  @override
  Future<String?> getIdToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_idIdToken);
  }

  @override
  Future<void> saveIdToken({String? idToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_idIdToken, idToken!);
  }
}
