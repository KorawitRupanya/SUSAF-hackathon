import 'package:flutter/material.dart';
import 'package:susaf_app/page/feature_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SusAF',
      theme: ThemeData.dark(useMaterial3: true),
      home: const FeaturePage(),
    );
  }
}
