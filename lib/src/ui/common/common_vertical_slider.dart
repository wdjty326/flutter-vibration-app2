import 'package:flutter/material.dart';

class CommonVerticalSlider extends StatelessWidget {
  final double sliderValue;
  final Function(double) onChanged;

  const CommonVerticalSlider({
    Key? key,
    required this.sliderValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Slider Value: $sliderValue'),
        RotatedBox(
          quarterTurns: 1,
          child: Slider(
            value: sliderValue,
            onChanged: onChanged,
            min: 0,
            max: 5,
            divisions: 1,
          ),
        ),
      ],
    );
  }
}
