import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:vibration/vibration.dart';

class VibrationBloc {
  /// 선택한 패턴
  final _selectPattern = BehaviorSubject<PatternModel?>.seeded(null);

  /// 진동 강도
  final _intensity = BehaviorSubject<double>.seeded(0);

  /// 진동 실행 여부
  final _isVibrate = BehaviorSubject<bool>.seeded(false);

  Stream<PatternModel?> get selectPattern => _selectPattern.stream;

  Stream<bool> get isVibrate => _isVibrate.stream;

  Stream<double> get intensity => _intensity.stream;

  changePattern(PatternModel? pattern) async {
    // StreamSubscription subscription = _selectPattern.stream.listen((_) async {
    //   await _restartVibration();
    // });
    // subscription.onDone(() {
    //   subscription.cancel();
    // });

    _selectPattern.sink.add(pattern);
  }

  changeIntensity(double value) async {
    StreamSubscription subscription = _intensity.stream.listen((event) async {
      if (value == event) await _restartVibration();
    });
    subscription.onDone(() {
      subscription.cancel();
    });

    _intensity.sink.add(value);
  }

  /// 진동시작
  startVibration() async {
    var hasVibrator = await Vibration.hasVibrator();
    hasVibrator = hasVibrator != null && hasVibrator;
    if (!hasVibrator) return;

    try {
      var isVibrate = _isVibrate.stream.value;
      if (isVibrate) return;

      var selectPattern = _selectPattern.stream.valueOrNull;
      if (selectPattern == null) return;

      /// TODO::amplitude이 지원되는 기기도 진폭제어가 안됨
      /// amplitude 옵션을 지원하지 않을시 처리
      var hasAmplitudeControl = await Vibration.hasAmplitudeControl();
      hasAmplitudeControl = hasAmplitudeControl != null && hasAmplitudeControl;

      var amplitude = max((_intensity.stream.value).toInt() * 200, 1);
      var intensities = selectPattern.intensities ?? [1, amplitude];

      debugPrint(
          '@hasAmplitudeControl: $hasAmplitudeControl, @amplitude: $amplitude');

      await Vibration.vibrate(
        pattern: selectPattern.pattern,
        repeat: selectPattern.loop ? 1 : 0,
        // amplitude: amplitude,
        intensities: intensities,
      );
      _isVibrate.sink.add(true);
    } catch (e) {
      _isVibrate.sink.addError(e);
    }
  }

  /// 진동정지
  stopVibration() async {
    var isVibrate = _isVibrate.stream.value;
    if (!isVibrate) return;

    try {
      await Vibration.cancel();
      _isVibrate.sink.add(false);
    } catch (e) {
      _isVibrate.sink.addError(e);
    }
  }

  _restartVibration() async {
    var isVibrate = _isVibrate.stream.value;
    if (!isVibrate) return;
    await stopVibration();
    if (_isVibrate.errorOrNull == null) await startVibration();
  }

  dispose() {
    debugPrint('@vibration dispose');

    _selectPattern.close();
    _intensity.close();
    _isVibrate.close();
  }
}

final vibrationBloc = VibrationBloc();
