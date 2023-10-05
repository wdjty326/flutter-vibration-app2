import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:vibration/vibration.dart';

class VibrationBloc {
  /// 선택한 패턴
  final _selectPattern = StreamController<PatternModel?>.broadcast();

  /// 진동 강도
  final _intensity = StreamController<double>.broadcast();

  /// 진동 실행 여부
  final _isVibrate = StreamController<bool>.broadcast();

  Stream<PatternModel?> get selectPattern => _selectPattern.stream;

  Stream<bool> get isVibrate => _isVibrate.stream;

  Stream<double> get intensity => _intensity.stream;

  initVibrationBloc() {
    _intensity.sink.add(0);
    _isVibrate.sink.add(false);
  }

  changePattern(PatternModel? pattern) async {
    await stopVibration();
    _selectPattern.sink.add(pattern);
  }

  changeIntensity(double value) {
    _intensity.sink.add(value);
  }

  /// 진동시작
  startVibration() async {
    var hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == null || !hasVibrator) return;

    var isVibrate = await _isVibrate.stream.single;
    if (isVibrate) return;

    var selectPattern = await _selectPattern.stream.single;
    if (selectPattern == null) return;

    try {
      var hasAmplitudeControl = await Vibration.hasAmplitudeControl();
      var amplitude = (await _intensity.stream.last).toInt() * 51;

      await Vibration.vibrate(
        pattern: selectPattern.pattern,
        repeat: selectPattern.loop ? 1 : 0,
        amplitude: amplitude,
      );
      _isVibrate.sink.add(true);
    } catch (e) {
      _isVibrate.sink.addError(e);
    }
  }

  /// 진동정지
  stopVibration() async {
    var isVibrate = await _isVibrate.stream.single;
    if (!isVibrate) return;

    try {
      await Vibration.cancel();
      _isVibrate.sink.add(false);
    } catch (e) {
      _isVibrate.sink.addError(e);
    }
  }

  dispose() {
    debugPrint('@vibration dispose');

    _selectPattern.close();
    _intensity.close();
    _isVibrate.close();
  }
}

final vibrationBloc = VibrationBloc();
