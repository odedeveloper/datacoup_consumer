import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    this.items,
  });

  List<QuizItem>? items;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        items:
            List<QuizItem>.from(json["items"].map((x) => QuizItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class QuizItem {
  QuizItem({
    this.count,
    this.questions,
    this.active,
    this.timeLimit,
    this.topic,
    this.timeStamp,
    this.quizId,
    this.name,
  });

  String? count;
  List<Question>? questions;
  String? active;
  String? timeLimit;
  String? topic;
  DateTime? timeStamp;
  String? quizId;
  String? name;

  factory QuizItem.fromJson(Map<String, dynamic> json) => QuizItem(
        count: json["count"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        active: json["active"],
        timeLimit: json["timeLimit"],
        topic: json["topic"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        quizId: json["quizId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
        "active": active,
        "timeLimit": timeLimit,
        "topic": topic,
        "timeStamp": timeStamp!.toIso8601String(),
        "quizId": quizId,
        "name": name,
      };
}

class Question {
  Question({
    this.question,
    this.options,
    this.message,
  });

  String? question;
  List<Option>? options;
  String? message;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "message": message,
      };
}

class Option {
  Option({
    this.item,
    this.ans,
  });

  String? item;
  bool? ans;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        item: json["item"],
        ans: json["ans"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "ans": ans,
      };
}
