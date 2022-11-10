// To parse this JSON data, do
//
//     final quizHistoryModel = quizHistoryModelFromJson(jsonString);

import 'dart:convert';

QuizHistoryModel quizHistoryModelFromJson(String str) =>
    QuizHistoryModel.fromJson(json.decode(str));

String quizHistoryModelToJson(QuizHistoryModel data) =>
    json.encode(data.toJson());

class QuizHistoryModel {
  QuizHistoryModel({
    this.items,
  });

  List<Item>? items;

  factory QuizHistoryModel.fromJson(Map<String, dynamic> json) =>
      QuizHistoryModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.score,
    this.timeStamp,
    this.odenId,
    this.selectedAnswers,
    this.quizId,
    this.topic,
    this.questions,
  });

  String? score;
  DateTime? timeStamp;
  String? odenId;
  List<List<String>>? selectedAnswers;
  String? quizId;
  String? topic;
  List<Question>? questions;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        score: json["score"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        odenId: json["odenId"],
        selectedAnswers: List<List<String>>.from(json["selectedAnswers"]
            .map((x) => List<String>.from(x.map((x) => x)))),
        quizId: json["quizId"],
        topic: json["topic"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "timeStamp": timeStamp!.toIso8601String(),
        "odenId": odenId,
        "selectedAnswers": List<dynamic>.from(
            selectedAnswers!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "quizId": quizId,
        "topic": topic,
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
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
