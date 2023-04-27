import 'package:flutter/material.dart';

enum Dimension {
  economic,
  environmental,
  social,
  individual,
  technical,
}

Map<int, String> probabilities = {
  0: "high",
  1: "medium",
  2: "low",
};

Map<int, String> levels = {
  0: "immediate",
  1: "enabling",
  2: "structural",
};

Map<int, String> impactTypes = {
  0: "positive",
  1: "negative",
  2: "neutral",
  3: "both",
};

Map<Dimension, Color> colors = {
  Dimension.economic: Colors.lightBlueAccent,
  Dimension.environmental: Colors.greenAccent,
  Dimension.social: Colors.amberAccent,
  Dimension.individual: Colors.orangeAccent,
  Dimension.technical: Colors.pinkAccent,
};
