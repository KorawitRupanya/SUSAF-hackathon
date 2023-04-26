import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/model/feature.dart';

Future<Feature> createFeature(
    {required int projectId, required String feature}) async {
  final response = await HttpClient.post(
    endpoint: '/features',
    data: {
      'Project_ID': projectId,
      'Features_Name': feature,
    },
  );

  final id = jsonDecode(response.body)['id'];
  return Feature(id: id, name: feature, projectId: projectId);
}

Future<List<Feature>> getAllProjectFeatures({required int projectId}) async {
  final response =
      await HttpClient.get(endpoint: '/features?ProjectID=$projectId');
  final jsonResponse = jsonDecode(response.body) as List;

  List<Feature> features = [];
  for (var e in jsonResponse) {
    Map<String, dynamic> json = Map.from(e);
    features.add(Feature.fromJson(json));
  }
  return features;
}

Future<Feature> getFeatureById(int id) async {
  final response = await HttpClient.get(endpoint: '/features?FeatureID=$id');
  final jsonResponse = jsonDecode(response.body) as List;
  Map<String, dynamic> json = Map.from(jsonResponse[0]);
  return Feature.fromJson(json);
}
