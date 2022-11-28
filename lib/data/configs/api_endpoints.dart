import 'dart:developer';

import 'package:datacoup/domain/model/news_model.dart';

const String FETCH_PROFILE_URL = 'user/profile';
const String CREATE_PROFILE_URL = 'user/profile';
const String DELETE_PROFILE_URL = 'user/profile';
const String PRIVACY_URL = 'https://www.odeinfinity.com/privacy-policy/';
const String TERMS_URL = 'https://www.odeinfinity.com/terms-conditions/';
const String HELP_URL = 'https://www.odeinfinity.com/';
const String UPLOAD_PROFILE_IMG_URL = 'user/profile/image';
const String FAVOURITE_NEWS = 'user/favourite';
const String UNFAVOURITE_NEWS = 'user/unfavourite';
const String GET_ACTIVITY = 'QnA/getActivity';
const String SUBMIT_ACTIVITY = 'QnA/submitActivity';
const String GET_HISTORY = 'QnA/getHistory';
const String GET_BEST_SCORE = 'QnA/getBestScore';
const String SET_USERNAME = '/setUsername';
const String DO_VERIFICATION = '/verification';
const String RESET_PASSWORD = '/resetPassword';
const String ADMIN_RESET_PASSWORD = '/adminResetPassword';

const String GET_PRIMARY_FROM_CONGITO = '/getPrimary';
const String EDIT_EMAIL_PHONE = '/editDetails';

String getSetUsernameUrl(String username) {
  return '/setUsername?username=$username';
}

String getPrimaryFromCognitoUrl(String username) {
  return '/getPrimary?username=$username';
}

String newsVideoListUrl(
    {String? type, int? count, String? lastEvaluatedKey, Location? location}) {
  if (lastEvaluatedKey == null) {
    log('news?newsType=$type&count=$count&country=${location!.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}');
    return 'news?newsType=$type&count=$count&country=${location.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}';
  } else {
    return 'news?newsType=$type&count=$count&LastEvaluatedKey=$lastEvaluatedKey&country=${location!.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}';
  }
}

String getBestScoreUrl(String odenId) {
  return 'QnA/getBestScore?odenId=$odenId';
}

String favouriteNewsUrl({int? count, String? lastEvaluatedKey}) {
  return "user/favourite?count=$count";
}

String getActivityUrl(String odenId, String topic) {
  if (topic == '') {
    return 'QnA/getActivity?odenId=$odenId';
  } else {
    return 'QnA/getActivity?odenId=$odenId&topic=$topic';
  }
}

String getHistoryUrl(String odenId, String topic) {
  if (topic == '') {
    return 'QnA/getHistory?odenId=$odenId';
  } else {
    return 'QnA/getHistory?odenId=$odenId&topic=$topic';
  }
}
