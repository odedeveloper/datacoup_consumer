import 'dart:developer';

import 'package:datacoup/domain/model/news_model.dart';

const String fetchUserProfileUrl = 'user/profile';
const String createUserProfileUrl = 'user/profile';

String newsVideoListUrl(
    {String? type, int? count, String? lastEvaluatedKey, Location? location}) {
  if (lastEvaluatedKey == null) {
    log('news?newsType=$type&count=$count&country=${location!.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}');
    return 'news?newsType=$type&count=$count&country=${location.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}';
  } else {
    return 'news?newsType=$type&count=$count&LastEvaluatedKey=$lastEvaluatedKey&country=${location!.country![0]}&state=${location.state![0]}&zipCode=${location.zipCode}';
  }
}
