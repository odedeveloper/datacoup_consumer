import 'package:datacoup/export.dart';

abstract class ApiRepositoryInterface {
  Future<CognitoUserPool> cogintoRegister();
  Future<User?> getUserFromToken(String? token);
  Future<LoginResponse?> login(LoginRequest login);
  Future<LoginResponse?> signUp(LoginRequest login);
  Future<LoginResponse?> fetchUserProfile();
  Future<void> logout(String? token);
  Future<List<Product>?> getProduct();
  Future<bool> checkAuthenticated();
}
