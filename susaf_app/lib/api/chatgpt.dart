import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/question.dart';

Future<String> generateAnswerSuggestion(
    {required String featureName, required Question question}) async {
  final String dim = question.dimension.name.split('.').last;
  final String prompt =
      "Consider the feature $featureName in the $dim dimension of sustainability with this background idea: ${question.background} Now, answer the following question for this feature: ${question.question} The answer should not exceed 200 characters.";

  final response = await HttpClient.post(
    endpoint: '/answer-suggestion',
    data: {'prompt': prompt},
  );

  return jsonDecode(response.body).toString().trim();
}

Future<List<String>> generateImpacts(
    {required int featureId, required Dimension dimension}) async {
  final String dim = dimension.name.split('.').last.toUpperCase();
  final response = await HttpClient.get(
      endpoint: '/impact-generation?feature_id=$featureId&dimension=$dim');

  final jsonResponse = jsonDecode(response.body) as List;
  List<String> impacts = [];
  for (var e in jsonResponse) {
    impacts.add(e.toString());
  }
  return impacts;
}
