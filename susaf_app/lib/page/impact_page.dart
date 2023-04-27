import 'package:card_loading/card_loading.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:susaf_app/api/chatgpt.dart';
import 'package:susaf_app/enums.dart';

class ImpactPage extends StatefulWidget {
  final int featureId;
  final Dimension dimension;
  const ImpactPage({
    super.key,
    required this.featureId,
    required this.dimension,
  });

  @override
  State<ImpactPage> createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
  final List<Widget> boxes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generateImpacts(
          featureId: widget.featureId, dimension: widget.dimension),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (boxes.isEmpty) {
            boxes.addAll((snapshot.data ?? []).map((p) => _buildImpactBox(p)));
          }
          return boxes.isEmpty
              ? const Text("AI could not generate impacts...")
              : ListView.builder(
                  itemCount: boxes.length,
                  itemBuilder: (context, index) => boxes[index],
                );
        } else {
          return _buildLoadingProjects();
        }
      },
    );
  }

  Widget _buildImpactBox(String impact) {
    int selectedLevel = 0, selectedType = 0, selectedProbability = 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ExpandablePanel(
        header: Card(
          color: Colors.teal,
          child: ListTile(
            title: Text(impact),
            // subtitle: Text(project.description),
          ),
        ),
        collapsed: Container(),
        expanded: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Level')),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          levels.keys.length,
                          (int index) {
                            return ChoiceChip(
                              selectedColor: Colors.greenAccent,
                              backgroundColor: Colors.teal,
                              label: Text(levels[index]!),
                              selected: selectedLevel == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedLevel = index;
                                  }
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Probability')),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          probabilities.keys.length,
                          (int index) {
                            return ChoiceChip(
                              selectedColor: Colors.greenAccent,
                              backgroundColor: Colors.teal,
                              label: Text(probabilities[index]!),
                              selected: selectedProbability == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedProbability = index;
                                  }
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Impact Type')),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          impactTypes.keys.length,
                          (int index) {
                            return ChoiceChip(
                              selectedColor: Colors.greenAccent,
                              backgroundColor: Colors.teal,
                              label: Text(impactTypes[index]!),
                              selected: selectedType == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedType = index;
                                  }
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
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
