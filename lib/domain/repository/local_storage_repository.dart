abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<void> saveDarkMode(bool? darkmode);
  Future<bool?> isDarkMode();
}
