import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:susaf_app/enums.dart';

class ImpactCard extends StatefulWidget {
  final String impact;
  const ImpactCard({super.key, required this.impact});

  @override
  State<ImpactCard> createState() => _ImpactCardState();
}

class _ImpactCardState extends State<ImpactCard> {
  int selectedLevel = 0, selectedType = 0, selectedProbability = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ExpandablePanel(
        header: Card(
          color: Colors.teal,
          child: ListTile(
            title: Text(widget.impact),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        theme: const ExpandableThemeData(
          useInkWell: true,
          tapHeaderToExpand: true,
          iconPlacement: ExpandablePanelIconPlacement.left,
          iconColor: Colors.white,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
        ),
        collapsed: Container(),
        expanded: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
}
