import 'package:cloud_firestore/cloud_firestore.dart';

/// firebase 에서 불러올 패턴 모델
class PatternModel {
  /// 패턴의 고유 id입니다.
  late String _id;

  /// 패턴명입니다.
  late String _name;

  /// 진동시간입니다. `pattern` 과 함께 사용할 수 없습니다.
  int? _duration;

  /// 패턴타입입니다. `duration` 과 함께 사용할 수 없습니다.
  List<int>? _pattern;

  /// 패턴의 진동 강도 리스트입니다. `amplitude` 와 함께 사용할 수 없습니다.
  /// 해당 값이 지정되면 진폭을 조절 할 수 없습니다.
  List<int>? _intensities;

  /// 패턴의 고정 진동 강도입니다. `intensities` 와 함께 사용할 수 없습니다.
  /// 해당 값이 지정되면 진폭을 조절 할 수 없습니다.
  int? _amplitude;

  /// 반복여부입니다.
  late bool _loop;

  /// 등록시간 여부입니다.
  late Timestamp _createTimestamp;

  PatternModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _name = parsedJson['name'];

    if (parsedJson['duration'] != null) {
      _duration = parsedJson['duration'];
    }
    if (parsedJson['pattern'] != null) {
      _pattern = List<int>.from(parsedJson['pattern']);
    }

    if (parsedJson['intensities'] != null) {
      _intensities = List<int>.from(parsedJson['intensities']);
    }
    if (parsedJson['amplitude'] != null) _amplitude = parsedJson['amplitude'];
    _loop = parsedJson['loop'];
    _createTimestamp = parsedJson['create_timestamp'];
  }

  String get id => _id;

  String get name => _name;

  int? get duration => _duration;

  List<int>? get pattern => _pattern;

  List<int>? get intensities => _intensities;

  int? get amplitude => _amplitude;

  bool get loop => _loop;

  Timestamp get createTimestamp => _createTimestamp;
}
