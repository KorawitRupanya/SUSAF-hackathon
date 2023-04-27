class Answer {
  final int id;
  final int featureId;
  final String questionId;
  final String answerText;
  final bool chatgpt;
  final bool isEdited;

  Answer({
    required this.id,
    required this.featureId,
    required this.questionId,
    required this.answerText,
    required this.chatgpt,
    required this.isEdited,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      featureId: json['feature_id'],
      questionId: json['question_id'],
      answerText: json['answer_text'],
      chatgpt: json['chatgpt'],
      isEdited: json['is_edited'],
    );
  }
}
