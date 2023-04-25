import 'package:flutter/material.dart';
import 'package:susaf_app/navbar.dart';
import 'package:susaf_app/projects.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      child: const ProjectGrid(),
    );
  }
}
