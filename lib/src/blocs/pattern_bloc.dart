import 'dart:async';

import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:flutter_vibration_app_2/src/resources/repository.dart';

class PatternBloc {
  final _repository = Repository();

  /// 패턴 리스트
  final _patternList = StreamController<List<PatternModel>>.broadcast();

  Stream<List<PatternModel>> get allPatterns => _patternList.stream;

  fetchAllPatterns() async {
    List<PatternModel> result = await _repository.fetchAllPatterns();
    _patternList.sink.add(result);
  }

  dispose() {
    _patternList.close();
  }
}

final bloc = PatternBloc();
