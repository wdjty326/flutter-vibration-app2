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
    StreamSubscription subscription = _selectPattern.stream.listen(null);
    subscription.onData((data) async {
      if (data == _selectPattern.stream.value) await _restartVibration();
      subscription.cancel();
    });

    _selectPattern.sink.add(pattern);
  }

  changeIntensity(double value) async {
    StreamSubscription subscription = _intensity.stream.listen(null);
    subscription.onData((data) async {
      if (_intensity.stream.value == data) await _restartVibration();
      subscription.cancel();
    });

    _intensity.sink.add(value);
  }

  Future<void> _startVibrationDuration(PatternModel selectPattern) async {
    var duration = selectPattern.duration ?? 500;

    /// hasAmplitudeControl 지원 여부에 따라서 처리 방식 변경
    var hasAmplitudeControl = await Vibration.hasAmplitudeControl();
    hasAmplitudeControl = hasAmplitudeControl != null && hasAmplitudeControl;
    var amplitude = hasAmplitudeControl
        ? max((_intensity.stream.value).toInt() * 51, 1)
        : -1;

    /// 커스텀 여부
    var hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport();
    hasCustomVibrationsSupport =
        hasCustomVibrationsSupport != null && hasCustomVibrationsSupport;

    if (hasCustomVibrationsSupport) {
      await Vibration.vibrate(
        duration: duration,
        amplitude: amplitude,
      );
      return;
    }

    do {
      if (!_isVibrate.stream.value) break;

      Vibration.vibrate(amplitude: amplitude);
      await Future.delayed(Duration(milliseconds: duration));
      Vibration.cancel();
    } while (selectPattern.loop);
  }

  Future<void> _startVibrationPattern(PatternModel selectPattern) async {
    var pattern = selectPattern.pattern ?? [];
    var intensities = selectPattern.intensities ??
        [1, max((_intensity.stream.value).toInt() * 51, 1)];

    /// 커스텀 여부
    var hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport();
    hasCustomVibrationsSupport =
        hasCustomVibrationsSupport != null && hasCustomVibrationsSupport;

    if (hasCustomVibrationsSupport) {
      await Vibration.vibrate(
        pattern: pattern,
        intensities: intensities,
        repeat: selectPattern.loop ? 1 : 0,
      );
      return;
    }
    do {
      if (!_isVibrate.stream.value) break;

      int count = 0;
      for (var milliseconds in pattern) {
        count++;
        if (count % 2 == 0) {
          await Future.delayed(Duration(milliseconds: milliseconds));
          break;
        }

        Vibration.vibrate(intensities: intensities.sublist(count, count + 2));
        await Future.delayed(Duration(milliseconds: milliseconds));
        Vibration.cancel();
      }
    } while (selectPattern.loop);
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

      if (selectPattern.pattern != null) {
        await _startVibrationPattern(selectPattern);
      } else {
        await _startVibrationDuration(selectPattern);
      }

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
