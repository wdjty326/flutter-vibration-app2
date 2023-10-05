import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';
import 'package:flutter_vibration_app_2/src/ui/common/common_vertical_slider.dart';
import 'package:flutter_vibration_app_2/src/ui/main_pattern_list.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    vibrationBloc.initVibrationBloc();
    return Column(
      children: [
        StreamBuilder(
            stream: vibrationBloc.intensity,
            builder: (context, snapshot) {
              debugPrint('@vibration: ${snapshot.hasData.toString()}');
              double sliderValue =
                  snapshot.hasData ? snapshot.requireData : 0.0;
              return CommonVerticalSlider(
                  sliderValue: sliderValue,
                  onChanged: (value) {
                    vibrationBloc.changeIntensity(value);
                  });
            }),
        StreamBuilder(
          stream: vibrationBloc.isVibrate,
          builder: (context, snapshot) {
            var isVibrate = snapshot.hasData ? snapshot.requireData : false;
            return ElevatedButton(
              onPressed: () {
                debugPrint('@vibrationBloc: isVibrate $isVibrate');
                if (isVibrate) return vibrationBloc.stopVibration();
                vibrationBloc.startVibration();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.pink), // 분홍색 배경
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Colors.black)), // 텍스트 색상
              ),
              child: Text(isVibrate ? 'stop' : 'start'),
            );
          },
        ),
        Expanded(child: MainPatternList()),
      ],
    );
  }
}
