import 'package:flutter/material.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/navbar.dart';

class DimensionPage extends StatefulWidget {
  final String featureId;
  final Dimension dimension;
  const DimensionPage(
      {super.key, required this.featureId, required this.dimension});

  @override
  State<DimensionPage> createState() => _DimensionPageState();
}

class _DimensionPageState extends State<DimensionPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      child: Text(widget.featureId),
    );
  }
}
