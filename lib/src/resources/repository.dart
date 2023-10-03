import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:flutter_vibration_app_2/src/resources/vibration_pattern_provider.dart';

class Repository {
  final vibrationPatternProvider = VibrationPatternProvider();

  Future<List<PatternModel>> fetchAllPatterns() =>
      vibrationPatternProvider.fetchPatternList();
}
