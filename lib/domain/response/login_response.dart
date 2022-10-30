import 'package:datacoup/export.dart';

class LoginResponse {
  final String? token;
  final User? user;
  LoginResponse({
    this.token,
    this.user,
  });
}
