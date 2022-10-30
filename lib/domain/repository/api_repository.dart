import 'package:datacoup/export.dart';

abstract class ApiRepositoryInterface {
  Future<CognitoUserPool> cogintoRegister();
  Future<User?> getUserFromToken(String? token);
  Future<String?> login(LoginRequest login);
  Future<String?> signUp(LoginRequest login);
  Future<LoginResponse?> fetchUserProfile();
  Future<void> logout(String? token);
  Future<List<Product>?> getProduct();
  Future<bool> checkAuthenticated();
}
