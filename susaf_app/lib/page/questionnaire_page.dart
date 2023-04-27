import 'package:flutter/material.dart';
import 'package:susaf_app/api/answer.dart';
import 'package:susaf_app/api/question.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/feature.dart';
import 'package:susaf_app/model/question.dart';
import 'package:susaf_app/widget/answer_field.dart';
import 'package:susaf_app/widget/background.dart';
import 'package:susaf_app/widget/question.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:editable/editable.dart';

class QuestionnairePage extends StatefulWidget {
  final Feature feature;
  final Dimension dimension;
  const QuestionnairePage(
      {super.key, required this.feature, required this.dimension});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  List<Question>? questions;
  int currentIndex = 0;

  List<Map<String, dynamic>> rows = [
    // {
    //   "background":
    //       'Value means the worth, or usefulness of something, principles or standards; judgement of what is important in life.',
    //   "question":
    //       'How can the product or service create or destroy monetary value ? For whom ?',
    //   "answer": 'Dummy answer',
    //   "chatGPT": '✅',
    //   "edit": '✅'
    // },
  ];
  List cols = [
    {
      "title": 'Background',
      'widthFactor': 0.1,
      'key': 'background',
      'editable': false
    },
    {
      "title": 'Question',
      'widthFactor': 0.2,
      'key': 'question',
      'editable': false
    },
    {"title": 'Answer', 'widthFactor': 0.25, 'key': 'answer', 'editable': true},
    {
      "title": 'Chat-GPT',
      'widthFactor': 0.05,
      'key': 'chatGPT',
      'editable': false
    },
    {
      "title": 'Is-Edited',
      'widthFactor': 0.05,
      'key': 'edit',
      'editable': false
    },
  ];

  void updateQuestion() {
    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final editableKey = GlobalKey<EditableState>();

    return FutureBuilder(
      future: getAllDimensionQuestions(dimension: widget.dimension),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          questions = snapshot.data;

          return Expanded(
            flex: 1,
            child: Card(
              color: Colors.transparent,
              elevation: 10,
              child: MultiSplitViewTheme(
                data: MultiSplitViewThemeData(
                  dividerPainter: DividerPainters.grooved1(
                    color: Colors.orange[100]!,
                    highlightedColor: Colors.orange[900]!,
                  ),
                ),
                child: Stack(
                  children: [
                    MultiSplitView(axis: Axis.vertical, initialAreas: [
                      Area(weight: 0.4)
                    ], children: [
                      MultiSplitView(
                        children: [
                          background(
                              context, questions![currentIndex].background),
                          question(context, questions![currentIndex].question),
                        ],
                      ),
                      MyForm(
                        feature: widget.feature,
                        question: questions![currentIndex],
                        onComplete: updateQuestion,
                      ),
                    ]),
                    Positioned(
                      bottom: 16.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          _buildAnswerTable(
                            context,
                            Editable(
                              key: editableKey,
                              columns: cols,
                              rows: rows,
                              zebraStripe: true,
                              stripeColor1: Colors.teal.shade900,
                              stripeColor2: Colors.teal.shade600,
                              onRowSaved: (value) {
                                print(value);
                              },
                              onSubmitted: (value) {
                                print(value);
                              },
                              borderColor: Colors.blueGrey,
                              tdStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              trHeight: 80,
                              thStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              thAlignment: TextAlign.center,
                              thVertAlignment: CrossAxisAlignment.end,
                              thPaddingBottom: 3,
                              showSaveIcon: true,
                              saveIconColor: Colors.white,
                              tdAlignment: TextAlign.center,
                              tdEditableMaxLines:
                                  100, // don't limit and allow data to wrap
                              tdPaddingTop: 10,
                              tdPaddingBottom: 10,
                              tdPaddingLeft: 10,
                              tdPaddingRight: 8,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.table_chart),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<dynamic> _buildAnswerTable(
      BuildContext context, Editable editableTable) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: FutureBuilder(
            future: getAllFeatureDimensionAnswers(
                featureId: widget.feature.id, dimension: widget.dimension),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var e in snapshot.data!) {
                  rows.add({
                    "background": e["background"],
                    "question": e["question"],
                    "answer": e["answer_text"],
                    "chatGPT": e["chatgpt"] == 1 ? '✔️' : '✘',
                    "edit": e["is_edited"] == 1 ? '✔️' : '✘',
                  });
                }
                return editableTable;
                // return ListView(
                //   shrinkWrap: true,
                //   children: [
                //     editableTable,
                //     ElevatedButton(
                //       onPressed: () {},
                //       child: const Text('Generate Impacts'),
                //     ),
                //   ],
                // );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
