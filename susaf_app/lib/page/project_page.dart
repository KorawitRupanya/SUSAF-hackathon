import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/project.dart';
import 'package:susaf_app/navbar.dart';
import 'package:susaf_app/page/dimension_page.dart';

class ProjectPage extends StatefulWidget {
  final Project project;
  const ProjectPage({super.key, required this.project});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<String> _features = [];
  final _formKey = GlobalKey<FormState>();
  final _featuresController = TextEditingController();

  @override
  void dispose() {
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            widget.project.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
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
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _featuresController,
                  decoration: InputDecoration(
                    hintText: 'Add Feature',
                  ),
                  onFieldSubmitted: (value) {
                    setState(() {
                      _features.add(value);
                      _featuresController.clear();
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the project
                      // ...
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
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
    for (var dim in Dimension.values) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DimensionPage(
                  featureId: feature,
                  dimension: dim,
                ),
              ),
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
