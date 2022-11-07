abstract class LocalRepositoryInterface {
  Future<void> saveRefreshToken();
  Future<String?> getRefreshToken();
  Future<void> saveIdToken();
  Future<String?> getIdToken();
  Future<void> clearAllData();
  Future<void> saveDarkMode(bool? darkmode);
  Future<bool?> isDarkMode();
}
