import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/api/project.dart';
import 'package:susaf_app/model/project.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final List<Widget> boxes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder(
            future: getAllProjects(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (boxes.isEmpty) {
                  boxes.addAll(
                      (snapshot.data ?? []).map((p) => _buildProjectBox(p)));
                }
                return boxes.isEmpty
                    ? const Text(
                        "You don't have any projects at the moment. Please create a new project to start your SusAF journey!")
                    : ListView.builder(
                        itemCount: boxes.length,
                        itemBuilder: (context, index) => boxes[index],
                      );
              } else {
                return _buildLoadingProjects();
              }
            },
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: _buildAddProjectBox(),
        ),
      ],
    );
  }

  Widget _buildProjectBox(Project project) {
    return GestureDetector(
      onTap: () => context.go('/projects/${project.id}'),
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final project = await createProject(
                        title: title, description: description);

                    setState(() {
                      boxes.add(_buildProjectBox(project));
                    });
                  }
                  _formKey.currentState?.reset();
                },
                icon: const Icon(Icons.add),
                label: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add New Project"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingProjects() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardLoading(
                      height: 60,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                );
              },
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
