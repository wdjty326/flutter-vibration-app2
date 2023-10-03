/// firebase 에서 불러올 패턴 모델
class PatternModel {
  late String _id;

  late List<PatternNameModal> _name;

  late List<int> _pattern;

  late List<int> _intensities;

  late int _amplitude;

  late bool _loop;

  PatternModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _pattern = List<int>.from(parsedJson['pattern']);
    _intensities = List<int>.from(parsedJson['intensities']);
    _amplitude = parsedJson['amplitude'];
    _loop = parsedJson['loop'];

    List<PatternNameModal> name = [];
    var nameMapper = Map<String, String>.from(parsedJson['name']);
    nameMapper.forEach((key, value) {
      name.add(PatternNameModal.fromJson(<String, String>{
        'key': key,
        'value': value,
      }));
    });
  }

  String get id => _id;

  List<PatternNameModal> get name => _name;

  List<int> get pattern => _pattern;

  List<int> get intensities => _intensities;

  int get amplitude => _amplitude;

  bool get loop => _loop;
}

class PatternNameModal {
  late String _key;
  late String _value;

  PatternNameModal.fromJson(Map<String, dynamic> parsedJson) {
    _key = parsedJson['key'];
    _value = parsedJson['value'];
  }

  String get key => _key;

  String get value => _value;
}
