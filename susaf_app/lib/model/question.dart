import 'package:susaf_app/enums.dart';

class Question {
  final String id;
  final Dimension dimension;
  final String background;
  final String question;

  Question({
    required this.id,
    required this.dimension,
    required this.background,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final dimension = Dimension.values.firstWhere((e) =>
        e.toString() ==
        "Dimension.${json['dimension']!.toString().toLowerCase()}");

    return Question(
      id: json['id'],
      dimension: dimension,
      background: json['background'],
      question: json['question'],
    );
  }
}
