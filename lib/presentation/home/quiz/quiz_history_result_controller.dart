import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuizHistoryResultController extends GetxController {
  int questionIndex = 0;
  int totalScore = 0;

  List<int> answersSelected = [];
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  QuizItemModel quiz = QuizItemModel(
      quizId: '',
      topic: '',
      count: '',
      timeLimit: '',
      timeStamp: '',
      questions: [],
      name: '');

  int noOfCorrectAnswers = 0;
  int noOfWrongAnswers = 0;
  List<int> correctlyAnsweredQuestions = [];

  List<List<int>> selectedAnswersPerQuestion = [];

  List<List<String>> selectedAnswersPerQuestionString = [];

  List<List<int>> correctAnswersPerQuestion = [];

  updateQuiz(quiz) {
    this.quiz = quiz;
    update();
  }

  updateActivity(ActivityItemModel activity) async {

    // problem in this fu
    quiz.questions = activity.questions;
    quiz.quizId = activity.quizId;
    quiz.topic = activity.topic;
    selectedAnswersPerQuestionString = activity.selectedAnswers;
    selectedAnswersPerQuestion = [];

    for (int i = 0; i < selectedAnswersPerQuestionString.length; i++) {
      List<int> temp = [];
      for (int j = 0; j < selectedAnswersPerQuestionString[i].length; j++) {
        print(selectedAnswersPerQuestionString[i][j]);
        var k = selectedAnswersPerQuestionString[i][j];
        temp.add(int.parse(selectedAnswersPerQuestionString[i][j]));
      }
      selectedAnswersPerQuestion.add(temp);
    }
    calculateScore();
  }

  updateTimeStamp() {
    quiz.timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  }

  getOptionColor(int optionIndex, int questionIndex) {
    dynamic optionColor = 0;
    print(optionIndex);
    print(questionIndex);
    if (!selectedAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      optionColor = Colors.grey;
      if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
        optionColor = Colors.green;

        return optionColor;
      }
    } else {
      if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
        optionColor = Colors.green;
      } else {
        optionColor = Colors.red;
      }
    }
    return optionColor;
  }

  getOptionStatus(int optionIndex, int questionIndex) {
    bool selected = false;
    bool correct = false;
    if (selectedAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      selected = true;
    }
    if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      correct = true;
    }
    return {"selected": selected, "correct": correct};
  }

  bool areListsEqual(var list1, var list2) {
    if (!(list1 is List && list2 is List) || list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  calculateScore() {
    for (var question in quiz.questions) {
      int qIndex = quiz.questions.indexOf(question);
      List<int> answerIndexList = [];
      for (var option in question.options) {
        int oIndex = quiz.questions[qIndex].options.indexOf(option);
        if (option.ans) {
          answerIndexList.add(oIndex);
        }
      }
      correctAnswersPerQuestion.add(answerIndexList);
    }
    for (int i = 0; i < selectedAnswersPerQuestion.length; i++) {
      selectedAnswersPerQuestion[i].sort();
    }
    for (int i = 0; i < quiz.questions.length; i++) {
      if (areListsEqual(
          selectedAnswersPerQuestion[i], correctAnswersPerQuestion[i])) {
        totalScore++;
        noOfCorrectAnswers++;
        correctlyAnsweredQuestions.add(i);
      } else {
        noOfWrongAnswers++;
      }
    }
    update();
  }
}
