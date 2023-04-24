import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:susaf_app/enums.dart';

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
    return const Placeholder();
  }
}
