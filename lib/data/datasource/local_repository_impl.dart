import 'package:datacoup/export.dart';

const _prefDarkTheme = "THEME_DARK";
const _idRefreshToken = "idRfreshToken";
const _idIdToken = "idIdToken";
const _userLogged = "userLogged";

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    GetStorage deviceStorage = GetStorage();
    saveDarkMode(false);
    deviceStorage.erase();
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

  @override
  Future<bool?> getuserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_userLogged);
  }

  @override
  Future<void> storeUserLogin({bool? log}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_userLogged, log!);
  }
}
