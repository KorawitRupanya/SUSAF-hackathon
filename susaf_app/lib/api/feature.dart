import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/model/feature.dart';

Future<Feature> createFeature(
    {required int projectId, required String feature}) async {
  final response = await HttpClient.post(
    endpoint: '/features',
    data: {
      'project_id': projectId,
      'name': feature,
    },
  );

  final id = jsonDecode(response.body)['id'];
  return Feature(id: id, name: feature, projectId: projectId);
}

Future<List<Feature>> getAllProjectFeatures({required int projectId}) async {
  final response =
      await HttpClient.get(endpoint: '/features?project_id=$projectId');
  final jsonResponse = jsonDecode(response.body) as List;

  List<Feature> features = [];
  for (var e in jsonResponse) {
    Map<String, dynamic> json = Map.from(e);
    features.add(Feature.fromJson(json));
  }
  return features;
}

Future<Feature> getFeatureById(int id) async {
  final response = await HttpClient.get(endpoint: '/features?id=$id');
  final jsonResponse = jsonDecode(response.body);
  Map<String, dynamic> json = Map.from(jsonResponse);
  return Feature.fromJson(json);
}
