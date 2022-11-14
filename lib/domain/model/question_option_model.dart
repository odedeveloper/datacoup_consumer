class QuestionOptionModel {
  String item = 'item';
  bool ans = false;

  QuestionOptionModel({
    required this.item,
    required this.ans,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> item) =>
      QuestionOptionModel(
        item: item['item'],
        ans: item['ans'],
      );

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'ans': ans,
    };
  }
}
