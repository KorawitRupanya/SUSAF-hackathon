import 'package:flutter/material.dart';
import 'package:susaf_app/api/answer.dart';
import 'package:susaf_app/api/chatgpt.dart';
import 'package:susaf_app/model/feature.dart';
import 'package:susaf_app/model/question.dart';

class MyForm extends StatefulWidget {
  final Feature feature;
  final Question question;
  final Function onComplete;

  const MyForm({
    Key? key,
    required this.feature,
    required this.question,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool chatgpt = false;
  bool isEdited = false;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: _textController,
                      focusNode: _focusNode,
                      validator: (value) {
                        if (value?.isEmpty != true) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        isEdited = true;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Your answer...',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      maxLines: 5,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        final suggestion = await generateAnswerSuggestion(
                            featureName: widget.feature.name,
                            question: widget.question);

                        chatgpt = true;
                        setState(() {
                          _textController.text = suggestion;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/ChatGPT_logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        String text = _textController.text;

                        await createAnswer(data: {
                          'answer_text': text,
                          'chatgpt': chatgpt,
                          'is_edited': isEdited,
                          'feature_id': widget.feature.id,
                          'question_id': widget.question.id,
                        });
                        _textController.clear();
                        _focusNode.unfocus();
                        widget.onComplete();
                      },
                      child: const Text(
                        'Submit',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        _textController.clear();
                        _focusNode.unfocus();
                        widget.onComplete();
                      },
                      child: const Text(
                        'Skip',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
