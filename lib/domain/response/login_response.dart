import 'package:datacoup/export.dart';

class LoginResponse {
  final String? token;
  final UserModel? user;
  final String? resMessage;
  LoginResponse({
    this.token,
    this.user,
    this.resMessage,
  });
}
