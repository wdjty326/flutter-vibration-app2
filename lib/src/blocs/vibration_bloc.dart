import 'dart:async';

import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:vibration/vibration.dart';

class VibrationBloc {
  /// 선택한 패턴
  final _selectPattern = StreamController<PatternModel?>.broadcast();

  Stream<PatternModel?> get selectPattern => _selectPattern.stream;

  changePattern(PatternModel? pattern) {
    _selectPattern.sink.add(pattern);
  }

  startVibration() async {
    var isCanVibration = await Vibration.hasVibrator();
    if (isCanVibration == null || !isCanVibration) return;

    var selectPattern = await _selectPattern.stream.last;
    if (selectPattern == null) return;

    Vibration.vibrate(pattern: selectPattern.pattern);
  }

  dispose() {
    _selectPattern.close();
  }
}
