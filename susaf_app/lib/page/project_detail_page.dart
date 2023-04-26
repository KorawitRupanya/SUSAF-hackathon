import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/api/feature.dart';
import 'package:susaf_app/api/project.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/feature.dart';
import 'package:susaf_app/model/project.dart';
import 'package:susaf_app/widget/loading.dart';

class ProjectDetailPage extends StatefulWidget {
  final int projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Project? project;
  final _formKey = GlobalKey<FormState>();
  final _featuresController = TextEditingController();

  final List<Widget> featureTiles = [];

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
          Column(
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
              Form(
                key: _formKey,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: _featuresController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.add),
                            hintText: 'Add Feature',
                          ),
                          onFieldSubmitted: (value) {
                            _addNewFeature();
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addNewFeature();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              FutureBuilder(
                future: getAllProjectFeatures(projectId: widget.projectId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (featureTiles.isEmpty) {
                      featureTiles.addAll(
                        (snapshot.data ?? []).asMap().entries.map((entry) {
                          int idx = entry.key;
                          Feature f = entry.value;

                          return _buildFeatureTile(f, idx);
                        }),
                      );
                    }
                    return featureTiles.isEmpty
                        ? const Text(
                            "This project doesn't have any features at the moment. Please add new features to get started!")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: featureTiles.length,
                            itemBuilder: (context, index) =>
                                featureTiles[index],
                          );
                  } else {
                    return buildLoadingCards();
                  }
                },
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: _features.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(bottom: 10),
              //       child: ListTile(
              //         isThreeLine: true,
              //         title: Padding(
              //           padding: const EdgeInsets.only(bottom: 5),
              //           child: Text(
              //             _features[index],
              //           ),
              //         ),
              //         subtitle: Row(
              //           children: _buildDimensionChips(_features[index]),
              //         ),
              //         trailing: IconButton(
              //           icon: const Icon(
              //             Icons.delete,
              //             color: Colors.blueGrey,
              //           ),
              //           onPressed: () {
              //             setState(() {
              //               _features.removeAt(index);
              //             });
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _addNewFeature() async {
    final feature = await createFeature(
      projectId: widget.projectId,
      feature: _featuresController.text,
    );
    setState(() {
      featureTiles.add(
        _buildFeatureTile(feature, featureTiles.length),
      );
      _featuresController.clear();
    });
  }

  List<Widget> _buildDimensionChips(Feature feature) {
    List<Widget> chips = List.empty(growable: true);

    for (var dim in Dimension.values) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () => context.go(
              "/projects/${widget.projectId}/features?featureId=${feature.id}&featureName=${feature.name}&dimension=${dim.name}",
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

  _buildFeatureTile(Feature feature, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        isThreeLine: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            feature.name,
          ),
        ),
        subtitle: Row(
          children: _buildDimensionChips(feature),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            setState(() {
              featureTiles.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}
