import 'package:susaf_app/enums.dart';

class Impact {
  final int id;
  final int featureId;
  final Dimension dimension;
  final String impactText;
  final String probability;
  final String level;
  final String impactType;

  Impact({
    required this.id,
    required this.featureId,
    required this.dimension,
    required this.impactText,
    required this.probability,
    required this.level,
    required this.impactType,
  });
}
