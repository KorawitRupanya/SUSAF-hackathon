import 'package:flutter/material.dart';

Widget question(BuildContext context, String questionText) {
  return Card(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Text(
                'Question',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.lightBlueAccent),
              ),
            ),
            Flexible(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      questionText,
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
