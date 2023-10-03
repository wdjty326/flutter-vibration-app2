import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/ui/test.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Test(),
      ),
    );
  }
}
