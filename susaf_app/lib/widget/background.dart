import 'package:flutter/material.dart';

const List<String> breakWords = ['means', 'refers', 'includes', 'steers'];

String _findTheme(String text) {
  int index;

  for (var word in breakWords) {
    index = text.indexOf(word);
    if (index != -1) {
      return text.substring(0, index).trim();
    }
  }
  return text;
}

Widget background(BuildContext context, String backgroundText) {
  return Card(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                'Theme : ${_findTheme(backgroundText)}',
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.tealAccent),
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      backgroundText,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
