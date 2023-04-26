class Feature {
  final int id;
  final String name;
  final int projectId;

  Feature({
    required this.id,
    required this.name,
    required this.projectId,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['Features_ID'],
      name: json['Features_Name'],
      projectId: json['Project_ID'],
    );
  }
}
