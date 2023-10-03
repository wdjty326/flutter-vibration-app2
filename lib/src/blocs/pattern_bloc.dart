import 'dart:async';

import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:flutter_vibration_app_2/src/resources/repository.dart';

class PatternBloc {
  final _repository = Repository();
  final _patternFetcher = StreamController<List<PatternModel>>.broadcast();

  Stream<List<PatternModel>> get allPatterns => _patternFetcher.stream;

  fetchAllPatterns() async {
    List<PatternModel> result = await _repository.fetchAllPatterns();
    _patternFetcher.sink.add(result);
  }

  dispose() {
    _patternFetcher.close();
  }
}

final bloc = PatternBloc();
