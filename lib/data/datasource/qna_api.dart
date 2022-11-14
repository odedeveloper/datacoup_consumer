import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:dio/dio.dart' as res;

Future<List<ActivityItemModel>> getHistory(String odenId, String topic) async {
  try {
    res.Response response =
        await DioInstance().dio.get(getHistoryUrl(odenId, topic = ''));
    List data = response.data['items'];
    List<ActivityItemModel> other =
        data.map((item) => (ActivityItemModel.fromJson(item))).toList();

    List<ActivityItemModel> other2 = List<ActivityItemModel>.from(other);

    return other2;
  } catch (error) {
    print(error);
    rethrow;
  }
}


Future<Map<String, dynamic>> getBestScore(String odenId) async {
  try {
    res.Response response =
        await DioInstance().dio.get(getBestScoreUrl(odenId));

    Map<String, dynamic> data = response.data;
    print(data);
    return data;
  } catch (error) {
    print(error);
    rethrow;
  }
}

Future<List<QuizItemModel>> getActivity(String odenId, String topic) async {
  try {
    res.Response response =
        await DioInstance().dio.get(getActivityUrl(odenId, topic = ''));

    List data = response.data['items'];
    // data = data.cast<List<QuizItemModel>>();
    print(data);

    if (data[0].runtimeType == String) {
      List<QuizItemModel> emptyQuiz = [];
      return emptyQuiz;
    } else {
      List other = (data.map((item) => QuizItemModel.fromJson(item))).toList();
      List<QuizItemModel> other2 = List<QuizItemModel>.from(other);
      return other2;
    }

    // return other;
  } catch (error) {
    print(error);
    rethrow;
  }
}

Future<void> submitActivity(List<List<int>> selectedAnswers, String score,
    String quizId, String odenId) async {
  List<List<String>> selectedAnswersString = [];
  for (var i in selectedAnswers) {
    List<String> temp = [];
    for (var j in i) {
      temp.add(j.toString());
    }
    selectedAnswersString.add(temp);
  }
  try {
    // res.Response response =
    await DioInstance().dio.post(SUBMIT_ACTIVITY, data: {
      'selectedAnswers': selectedAnswersString,
      'score': score,
      'quizId': quizId,
      'odenId': odenId
    });

    // List data = response.data['items'];
    // return data;
  } catch (error) {
    print(error);
    rethrow;
  }
}
