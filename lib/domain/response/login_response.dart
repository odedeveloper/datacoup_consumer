import 'package:datacoup/export.dart';

class LoginResponse {
  final String? token;
  final User? user;
  final String? resMessage;
  LoginResponse({
    this.token,
    this.user,
    this.resMessage,
  });
}
