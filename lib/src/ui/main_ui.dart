import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/ui/common/common_vertical_slider.dart';
import 'package:flutter_vibration_app_2/src/ui/test.dart';

class MainUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonVerticalSlider(sliderValue: 0, onChanged: (value) {}),
        Expanded(child: Test()),
      ],
    );
  }
}
