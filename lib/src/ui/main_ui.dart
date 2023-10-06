import 'package:flutter/material.dart';

import 'package:flutter_vibration_app_2/src/ui/main_pattern_button.dart';
import 'package:flutter_vibration_app_2/src/ui/main_pattern_list.dart';
import 'package:flutter_vibration_app_2/src/ui/main_pattern_slider.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainPatternSlider(),
        MainPatternButton(),
        MainPatternList(),
      ],
    );
  }
}
