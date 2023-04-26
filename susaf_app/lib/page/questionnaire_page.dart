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
  List<String> bg = [
    'Value means the worth, or usefulness of something, principles or standards; judgement of what is important in life.',
    'Governance means the processes of interaction and decision-making among the actors involved in a system through the laws, norms, power or language of an organized society.'
  ];
  List<String> qs = [
    'How can the product or service create or destroy monetary value ? For whom ?',
    'How can these changes impact the financial situation of the business and partners?'
  ];
  int bgIndex = 0;
  int qsIndex = 0;

  void updateQuestion() {
    setState(() {
      bgIndex = bgIndex + 1;
      qsIndex = qsIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    String bgCurrent = bg[bgIndex];
    String qsCurrent = qs[qsIndex];

    MultiSplitView multiSplitView =
        MultiSplitView(axis: Axis.vertical, children: [
      MultiSplitView(
        children: [
          background(context, bgCurrent),
          question(context, qsCurrent),
        ],
      ),
      MyForm(
        onComplete: updateQuestion,
      ),
    ]);

    final editableKey = GlobalKey<EditableState>();

    List rows = [
      {
        "no": '1',
        "background":
            'Value means the worth, or usefulness of something, principles or standards; judgement of what is important in life.',
        "question":
            'How can the product or service create or destroy monetary value ? For whom ?',
        "answer": 'Dummy answer',
        "chatGPT": '✅',
        "edit": '✅'
      },
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
      {
        "title": 'Answer',
        'widthFactor': 0.2,
        'key': 'answer',
        'editable': true
      },
      {
        "title": 'ChatGPT',
        'widthFactor': 0.075,
        'key': 'chatGPT',
        'editable': false
      },
      {
        "title": 'Is Edited',
        'widthFactor': 0.075,
        'key': 'edit',
        'editable': false
      },
    ];

    void _addNewRow() {
      setState(() {
        editableKey.currentState?.createRow();
      });
    }

    void _printEditedRows() {
      List? editedRows = editableKey.currentState?.editedRows;
      print(editedRows);
    }

    Editable editableTable = Editable(
      key: editableKey,
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
              multiSplitView,
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: floatingActionButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
