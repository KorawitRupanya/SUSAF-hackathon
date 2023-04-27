import 'package:susaf_app/enums.dart';

class Impact {
  final int id;
  final int featureId;
  final Dimension dimension;
  final String impactText;
  final Probability probability;
  final Level level;
  final ImpactType impactType;

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
