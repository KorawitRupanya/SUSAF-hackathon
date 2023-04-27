import 'package:flutter/material.dart';

enum Dimension {
  economic,
  environmental,
  social,
  individual,
  technical,
}

enum Probability {
  high,
  medium,
  low,
}

enum Level {
  immediate,
  enabling,
  structural,
}

enum ImpactType {
  positive,
  negative,
  neutral,
  both,
}

Map<Dimension, Color> colors = {
  Dimension.economic: Colors.lightBlueAccent,
  Dimension.environmental: Colors.greenAccent,
  Dimension.social: Colors.amberAccent,
  Dimension.individual: Colors.orangeAccent,
  Dimension.technical: Colors.pinkAccent,
};
