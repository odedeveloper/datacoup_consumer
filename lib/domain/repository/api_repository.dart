import 'package:datacoup/domain/model/quiz_model.dart';
import 'package:datacoup/export.dart';

abstract class ApiRepositoryInterface {
  Future<CognitoUserPool> cogintoRegister();
  Future<User?> getUserFromToken(String? token);
  Future<String?> login(LoginRequest login);
  Future<String?> signUp(LoginRequest login);
  Future<User?> createUpdateUser(User user);
  Future<String?> uploadProfileImage(String filePath);
  Future<LoginResponse?> fetchUserProfile();
  Future<void> logout(String? token);
  Future<bool> checkAuthenticated();
  Future<NewsModel?> getNews({
    required String? type,
    required int? count,
    required String? lastEvaluatedKey,
    required Location? location,
  });
  Future<NewsModel?> getFavouriteNews({
    required bool? type,
    required int? count,
    required String? lastEvaluatedKey,
  });
  Future<String?> postFavouriteNews({String? newsId, bool? isLiked});
  Future<QuizModel?> getQuizzies({String? odenId, String? topic});
}
