import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';
import 'package:flutter_vibration_app_2/firebase_options.dart';

class VibrationPatternProvider {
  Future<List<PatternModel>> fetchPatternList() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    var db = FirebaseFirestore.instance;

    List<PatternModel> result = [];
    await db.collection('/vibration_pattern').get().then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        data.addAll({'id': doc.id});
        result.add(PatternModel.fromJson(data));
      }
    });

    return result;
  }
}
