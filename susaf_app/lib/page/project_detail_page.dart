import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/api/project.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/project.dart';

class ProjectDetailPage extends StatefulWidget {
  final int projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Project? project;
  final List<String> _features = [];
  final _formKey = GlobalKey<FormState>();
  final _featuresController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProjectById(widget.projectId);
  }

  @override
  void dispose() {
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getProjectById(widget.projectId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                project = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project?.title ?? "",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      project?.description ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                );
              } else {
                return const CardLoading(
                  width: 400,
                  height: 60,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  margin: EdgeInsets.symmetric(vertical: 5),
                );
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(
                  thickness: 5,
                ),
                const SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        isThreeLine: true,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            _features[index],
                          ),
                        ),
                        subtitle: Row(
                          children: _buildDimensionChips(_features[index]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _features.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _featuresController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.add),
                    hintText: 'Add Feature',
                  ),
                  onFieldSubmitted: (value) {
                    setState(() {
                      _features.add(value);
                      _featuresController.clear();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the project
                      // ...
                      setState(() {
                        _features.add(_featuresController.text);
                        _featuresController.clear();
                      });
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDimensionChips(String feature) {
    List<Widget> chips = List.empty(growable: true);

    int featureId = 1;

    for (var dim in Dimension.values) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () => context.go(
              "/projects/${widget.projectId}/features?featureId=$featureId&featureName=$feature&dimension=${dim.name}",
            ),
            child: Chip(
              label: Text(dim.name),
              backgroundColor: colors[dim],
            ),
          ),
        ),
      );
    }

    return chips;
  }
}
