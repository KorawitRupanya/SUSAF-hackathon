import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/page/questionnaire_page.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadCrumb(
          items: [
            BreadCrumbItem(content: Text(widget.featureId)),
            BreadCrumbItem(content: Text(widget.dimension.name)),
          ],
          divider: const Icon(Icons.chevron_right),
        ),
        const QuestionnairePage(),
      ],
    );
  }
}
