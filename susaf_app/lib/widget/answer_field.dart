import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.04;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Please enter your answer here',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        focusNode: _focusNode,
                        validator: (value) {
                          if (value?.isEmpty != true) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter some text',
                          // hintStyle: TextStyle(fontSize: fontSize),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        maxLines: null,
                        // style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('ChatGPT-3 Triggered');
                      },
                      icon: Image.asset(
                        '../../../assets/ChatGPT_logo.png',
                        height: fontSize * 2,
                        width: fontSize * 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      // Submit form
                      String text = _textController.text;
                      print('Submitted text: $text');
                      _focusNode.unfocus();
                    }
                  },
                  // style: ElevatedButton.styleFrom(
                  //   minimumSize: Size(screenWidth * 0.3, 0),
                  // ),
                  child: const Text(
                    'Submit',
                    // style: TextStyle(fontSize: fontSize),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Skip form
                    print('Skipped form');
                    _focusNode.unfocus();
                  },
                  // style: TextButton.styleFrom(
                  //   minimumSize: Size(screenWidth * 0.3, 0),
                  // ),
                  child: const Text(
                    'Skip',
                    // style: TextStyle(fontSize: fontSize),
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
