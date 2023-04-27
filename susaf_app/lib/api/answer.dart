import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/answer.dart';

Future<Answer> createAnswer({required Map<String, dynamic> data}) async {
  final response = await HttpClient.post(
    endpoint: '/answers',
    data: data,
  );

  final id = jsonDecode(response.body)['id'];
  return Answer(
    id: id,
    featureId: data['feature_id'],
    questionId: data['question_id'],
    answerText: data['answer_text'],
    chatgpt: data['chatgpt'],
    isEdited: data['is_edited'],
  );
}

Future<List<Map<String, dynamic>>> getAllFeatureDimensionAnswers(
    {required int featureId, required Dimension dimension}) async {
  final String dim = dimension.name.split('.').last.toUpperCase();
  final response = await HttpClient.get(
      endpoint: '/answers?feature_id=$featureId&dimension=$dim');

  final jsonResponse = jsonDecode(response.body) as List;

  List<Map<String, dynamic>> answers = [];
  for (var e in jsonResponse) {
    Map<String, dynamic> json = Map.from(e);
    answers.add(json);
  }
  return answers;
}
