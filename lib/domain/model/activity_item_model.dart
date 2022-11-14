import 'package:datacoup/domain/model/question_item_model.dart';

class ActivityItemModel {
  String quizId = '';
  String score = '';
  String topic = '';
  String badge = '';
  String odenId = '';
  String timestamp = '';
  List<List<String>> selectedAnswers = [];
  List<QuestionItemModel> questions = [];

  ActivityItemModel(
      {required this.quizId,
      required this.topic,
      required this.score,
      required this.badge,
      required this.timestamp,
      required this.odenId,
      required this.selectedAnswers,
      required this.questions});

  static makeSelectedAnwersList(List<dynamic> value) {
    return value.map((e) => List<String>.from(e)).toList();
  }

  static makeQuestionList(List<dynamic> value) {
    return value.map((e) => QuestionItemModel.fromJson(e)).toList();
  }

  factory ActivityItemModel.fromJson(Map<String, dynamic> item) =>
      ActivityItemModel(
        quizId: item['quizId'],
        score: item.containsKey("score") ? item['score'] : '',
        topic: item.containsKey("topic") ? item['topic'] : '',
        badge: item.containsKey("badge") ? item['badge'] : '',
        timestamp: item.containsKey("timeStamp") ? item['timeStamp'] : '',
        odenId: item['odenId'],
        selectedAnswers: item.containsKey('selectedAnswers')
            ? makeSelectedAnwersList(item['selectedAnswers'])
            : [],
        questions: item.containsKey("questions")
            ? makeQuestionList(item['questions'])
            : [],
      );

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'score': score,
      'topic': topic,
      'badge': badge,
      'timestamp': timestamp,
      'odenId': odenId,
      'selectedAnswers': selectedAnswers,
      'questions': questions
    };
  }
}
