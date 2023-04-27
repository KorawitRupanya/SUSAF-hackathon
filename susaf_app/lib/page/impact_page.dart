import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/api/chatgpt.dart';
import 'package:susaf_app/api/project.dart';
import 'package:susaf_app/enums.dart';
import 'package:susaf_app/model/project.dart';

class ImpactPage extends StatefulWidget {
  final int featureId;
  final Dimension dimension;
  const ImpactPage({
    super.key,
    required this.featureId,
    required this.dimension,
  });

  @override
  State<ImpactPage> createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
  final List<Widget> boxes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generateImpacts(
          featureId: widget.featureId, dimension: widget.dimension),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (boxes.isEmpty) {
            boxes.addAll((snapshot.data ?? []).map((p) => _buildProjectBox(p)));
          }
          return boxes.isEmpty
              ? const Text(
                  "You don't have any projects at the moment. Please create a new project to start your SusAF journey!")
              : ListView.builder(
                  itemCount: boxes.length,
                  itemBuilder: (context, index) => boxes[index],
                );
        } else {
          return _buildLoadingProjects();
        }
      },
    );
  }

  Widget _buildProjectBox(String impact) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.teal,
        child: ListTile(
          title: Text(impact),
          // subtitle: Text(project.description),
        ),
      ),
    );
  }

  Widget _buildLoadingProjects() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardLoading(
                      height: 60,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                );
              },
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
