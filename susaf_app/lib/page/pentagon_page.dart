import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

class PentagonPage extends StatelessWidget {
  const PentagonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 500,
          height: 500,
          padding: const EdgeInsets.all(18.0),
          decoration: ShapeDecoration(
            color: Colors.blueAccent.shade100,
            shape: PolygonBorder(
              sides: 5,
            ),
          ),
        ),
        Container(
          width: 350,
          height: 350,
          padding: const EdgeInsets.all(18.0),
          decoration: ShapeDecoration(
            color: Colors.lightBlueAccent.shade100,
            shape: PolygonBorder(
              sides: 5,
            ),
          ),
        ),
        Container(
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(18.0),
          decoration: ShapeDecoration(
            color: Colors.lightBlue.shade100,
            shape: PolygonBorder(
              sides: 5,
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Text(
            'Feature',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Positioned(
          left: 200,
          top: 70,
          child: Text('Social'),
        ),
        Positioned(
          right: 200,
          top: 70,
          child: Text('Individual'),
        ),
        Positioned(
          left: 100,
          bottom: 150,
          child: Text('Environmental'),
        ),
        Positioned(
          right: 100,
          bottom: 150,
          child: Text('Technical'),
        ),
        Positioned(
          // left: 200,
          bottom: 20,
          child: Text('Economic'),
        ),
      ],
    );
  }
}
