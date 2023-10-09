/// firebase 에서 불러올 패턴 모델
class PatternModel {
  /// 패턴의 고유 id입니다.
  late String _id;

  /// 패턴명입니다.
  late String _name;

  late List<int> _pattern;

  /// 패턴의 진동 강도 리스트입니다.
  List<int>? _intensities;

  /// 패턴의 진동 강도입니다.
  int? _amplitude;

  /// 반복여부입니다.
  late bool _loop;

  PatternModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _name = parsedJson['name'];
    _pattern = List<int>.from(parsedJson['pattern']);
    if (parsedJson['intensities'] != null) {
      _intensities = List<int>.from(parsedJson['intensities']);
    }
    if (parsedJson['amplitude'] != null) _amplitude = parsedJson['amplitude'];
    _loop = parsedJson['loop'];
  }

  String get id => _id;

  String get name => _name;

  List<int> get pattern => _pattern;

  List<int>? get intensities => _intensities;

  int? get amplitude => _amplitude;

  bool get loop => _loop;
}
