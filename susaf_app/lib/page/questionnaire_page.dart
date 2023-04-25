import 'dart:html';

import 'package:flutter/material.dart';
import 'package:susaf_app/widget/answer_field.dart';
import 'package:susaf_app/widget/background.dart';
import 'package:susaf_app/widget/question.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:editable/editable.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  @override
  Widget build(BuildContext context) {
    MultiSplitView multiSplitView =
        MultiSplitView(axis: Axis.vertical, children: [
      MultiSplitView(
        initialAreas: [Area(weight: 0.3)],
        children: [
          background(context, 'Lorem'),
          question(context, 'Lorem'),
        ],
      ),
      const MyForm(),
    ]);

    final _editableKey = GlobalKey<EditableState>();

    List rows = [
      {
        "no": '1',
        "background": 'Test',
        "question": 'Test',
        "answer": 'Test',
        "chatGPT": '✅',
        "edit": '✅'
      },
    ];
    List cols = [
      {"title": 'No', 'widthFactor': 0.05, 'key': 'no', 'editable': false},
      {"title": 'Background', 'widthFactor': 0.2, 'key': 'background', 'editable': false},
      {"title": 'Question', 'widthFactor': 0.2, 'key': 'question', 'editable': false},
      {"title": 'Answer', 'widthFactor': 0.2, 'key': 'answer', 'editable': true},
      {"title": 'ChatGPT', 'widthFactor': 0.05, 'key': 'chatGPT', 'editable': false},
      {"title": 'Is Edited', 'widthFactor': 0.05, 'key': 'edit', 'editable': false},
    ];

    void _addNewRow() {
      setState(() {
        _editableKey.currentState?.createRow();
      });
    }

    void _printEditedRows() {
      List? editedRows = _editableKey.currentState?.editedRows;
      print(editedRows);
    }

    Editable editableTable = Editable(
      key: _editableKey,
      columns: cols,
      rows: rows,
      zebraStripe: true,
      stripeColor1: Colors.blue,
      stripeColor2: Colors.grey,
      onRowSaved: (value) {
        print(value);
      },
      onSubmitted: (value) {
        print(value);
      },
      borderColor: Colors.blueGrey,
      tdStyle: const TextStyle(fontWeight: FontWeight.bold),
      trHeight: 80,
      thStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      thAlignment: TextAlign.center,
      thVertAlignment: CrossAxisAlignment.end,
      thPaddingBottom: 3,
      showSaveIcon: true,
      saveIconColor: Colors.white,
      tdAlignment: TextAlign.center,
      tdEditableMaxLines: 100, // don't limit and allow data to wrap
      tdPaddingTop: 10,
      tdPaddingBottom: 14,
      tdPaddingLeft: 10,
      tdPaddingRight: 8,
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(0))),
    );

    FloatingActionButton floatingActionButton = FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: editableTable),
            );
          },
        );
      },
      child: const Icon(Icons.table_chart),
    );

    return Expanded(
      flex: 1,
      child: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainters.grooved1(
            color: Colors.orange[100]!,
            highlightedColor: Colors.orange[900]!,
          ),
        ),
        child: Stack(
          children: [
            multiSplitView,
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: floatingActionButton,
            ),
          ],
        ),
      ),
    );
  }
}
