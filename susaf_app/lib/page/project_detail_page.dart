import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/feature.dart';

class ProjectDetailPage extends StatefulWidget {
  final int projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final List<String> _features = [];
  final _formKey = GlobalKey<FormState>();
  final _featuresController = TextEditingController();

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
          Text(
            "Project ${widget.projectId}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          // Text(
          //   widget.project.description,
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(
                  thickness: 5,
                ),
                const SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      title: Text(_features[index]),
                      subtitle: Row(
                        children: _buildDimensionChips(_features[index]),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _features.removeAt(index);
                          });
                        },
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
                      Navigator.pop(context);
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
    Feature featureObj = Feature(id: 1, name: feature, projectId: 1);
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
