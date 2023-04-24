import 'package:flutter/material.dart';

enum Dimension {
  economic,
  environmental,
  social,
  individual,
  technical,
}

Map<Dimension, Color> colors = {
  Dimension.economic: Colors.lightBlueAccent,
  Dimension.environmental: Colors.greenAccent,
  Dimension.social: Colors.amberAccent,
  Dimension.individual: Colors.orangeAccent,
  Dimension.technical: Colors.pinkAccent,
};
