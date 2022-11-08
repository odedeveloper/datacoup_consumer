abstract class LocalRepositoryInterface {
  Future<void> saveRefreshToken();
  Future<String?> getRefreshToken();
  Future<bool?> getuserLoggedIn();
  Future<void> storeUserLogin({bool? log});
  Future<void> saveIdToken();
  Future<String?> getIdToken();
  Future<void> clearAllData();
  Future<void> saveDarkMode(bool? darkmode);
  Future<bool?> isDarkMode();
}
