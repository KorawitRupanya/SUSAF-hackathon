import 'package:flutter/material.dart';

Widget background(BuildContext context, String backgroundText) {
  return Card(
    child: Center(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Background',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.amberAccent),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
          ),
        ],
      ),
    ),
  );
}
