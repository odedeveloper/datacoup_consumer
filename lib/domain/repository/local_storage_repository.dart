import 'package:datacoup/export.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<User?> saveUser(User? user);
  Future<User?> getUser();
  Future<void> saveDarkMode(bool? darkmode);
  Future<bool?> isDarkMode();
  
}
