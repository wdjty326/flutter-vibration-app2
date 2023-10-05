import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/ui/common/common_app_bar.dart';
import 'package:flutter_vibration_app_2/src/ui/main_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: CommonAppBar(appBar: AppBar(), title: '우리의 은밀한 울림'),
        body: MainUI(),
      ),
    );
  }
}
