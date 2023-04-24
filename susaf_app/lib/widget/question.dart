import 'package:flutter/material.dart';

Widget question(BuildContext context, String questionText) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Card(
    child: Center(
      child: Column(
        children: [
          Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  'Question',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              )),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      questionText,
                      style: TextStyle(
                        fontSize: screenWidth * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
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
