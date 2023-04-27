import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/question.dart';

Future<List<Question>> getAllDimensionQuestions(
    {required Dimension dimension}) async {
  final dimensionStr = dimension.name.split('.').last.toUpperCase();

  final response =
      await HttpClient.get(endpoint: '/questions?dimension=$dimensionStr');
  final jsonResponse = jsonDecode(response.body) as List;

  List<Question> questions = [];
  for (var e in jsonResponse) {
    Map<String, dynamic> json = Map.from(e);
    questions.add(Question.fromJson(json));
  }

  return questions;
}
