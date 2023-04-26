import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

Widget buildLoadingCards() {
  return CustomScrollView(
    shrinkWrap: true,
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
            childCount: 3,
          ),
        ),
      ),
    ],
  );
}
