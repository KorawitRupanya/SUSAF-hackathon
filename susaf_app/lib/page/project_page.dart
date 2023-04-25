import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectBox {
  final String title;
  final String description;

  ProjectBox({required this.title, required this.description});
}

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final List<ProjectBox> _projects = [
    ProjectBox(title: 'Project 1', description: 'This is project 1'),
    ProjectBox(title: 'Project 2', description: 'This is project 2'),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 50,
      crossAxisSpacing: 50,
      children: [
        ..._projects.map((project) => _buildProjectBox(project)),
        _buildAddProjectBox(),
      ],
    );
  }

  Widget _buildProjectBox(ProjectBox project) {
    return GestureDetector(
      onTap: () => context.go('/projects/1'),
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ProjectDetailPage(
      //       // project: Project(
      //       //   id: 1,
      //       //   title: project.title,
      //       //   description: project.description,
      //       // ),
      //       projectId: 1,
      //     ),
      //   ),
      // ),
      child: Card(
        color: Colors.teal,
        child: ListTile(
          title: Text(project.title),
          subtitle: Text(project.description),
        ),
      ),
    );
  }

  Widget _buildAddProjectBox() {
    String title = "", description = "";
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Project Title"),
                onChanged: (value) => title = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 3,
                decoration:
                    const InputDecoration(labelText: "Project Description"),
                onChanged: (value) => description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _projects.add(
                        ProjectBox(
                          title: title,
                          description: description,
                        ),
                      );
                    });
                  }
                  _formKey.currentState?.reset();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Project"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
