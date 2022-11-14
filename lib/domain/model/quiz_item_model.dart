import 'package:datacoup/domain/model/question_item_model.dart';

class QuizItemModel {
  String quizId = '';
  String topic = '';
  String count = '';
  String timeLimit = '';
  String timeStamp = '';
  String name = '';
  List<QuestionItemModel> questions = [];

  QuizItemModel({
    required this.quizId,
    required this.topic,
    required this.count,
    required this.timeLimit,
    required this.timeStamp,
    required this.questions,
    required this.name,
  });

  static makeQuestionList(List<dynamic> value) {
    return value.map((e) => QuestionItemModel.fromJson(e)).toList();
  }

  factory QuizItemModel.fromJson(Map<String, dynamic> item) => QuizItemModel(
        quizId: item['quizId'],
        count: item.containsKey("count") ? item['count'] : '',
        topic: item.containsKey("topic") ? item['topic'] : '',
        timeLimit: item.containsKey("timeLimit") ? item['timeLimit'] : '',
        timeStamp: item.containsKey("timeStamp") ? item['timeStamp'] : '',
        questions: item.containsKey("questions")
            ? makeQuestionList(item['questions'])
            : [],
        name: item.containsKey("name") ? item['name'] : '',
      );

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'count': count,
      'topic': topic,
      'timeLimit': timeLimit,
      'timeStamp': timeStamp,
      'questions': questions,
      'name': name
    };
  }
}
