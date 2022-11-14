import 'package:datacoup/domain/model/question_option_model.dart';

class QuestionItemModel {
  String question = 'question';
  String message = '';
  List<QuestionOptionModel> options = [];

  QuestionItemModel({
    required this.question,
    required this.message,
    required this.options,
  });

  static makeOptionsList(List<dynamic> value) {
    return value.map((e) => QuestionOptionModel.fromJson(e)).toList();
  }

  factory QuestionItemModel.fromJson(Map<String, dynamic> item) =>
      QuestionItemModel(
        question: item['question'],
        message: item['message'],
        options: makeOptionsList(item['options']),
      );

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'message': message,
      'options': options,
    };
  }
}
