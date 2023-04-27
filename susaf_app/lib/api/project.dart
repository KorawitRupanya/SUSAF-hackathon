import 'dart:convert';

import 'package:susaf_app/api/http_client.dart';
import 'package:susaf_app/model/project.dart';

Future<Project> createProject(
    {required String title, required String description}) async {
  final response = await HttpClient.post(
    endpoint: '/projects',
    data: {
      'title': title,
      'description': description,
    },
  );

  final id = jsonDecode(response.body)['id'];
  return Project(id: id, title: title, description: description);
}

Future<List<Project>> getAllProjects() async {
  final response = await HttpClient.get(endpoint: '/projects');
  final jsonResponse = jsonDecode(response.body) as List;

  List<Project> projects = [];
  for (var e in jsonResponse) {
    Map<String, dynamic> json = Map.from(e);
    projects.add(Project.fromJson(json));
  }
  return projects;
}

Future<Project> getProjectById(int id) async {
  final response = await HttpClient.get(endpoint: '/projects?id=$id');
  final jsonResponse = jsonDecode(response.body);
  Map<String, dynamic> json = Map.from(jsonResponse);
  return Project.fromJson(json);
}
