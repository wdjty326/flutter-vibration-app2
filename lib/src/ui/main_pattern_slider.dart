import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';

class MainPatternSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: vibrationBloc.intensity,
        builder: (context, snapshot) {
          debugPrint('@vibration: ${snapshot.hasData.toString()}');
          double sliderValue = snapshot.hasData ? snapshot.requireData : 0.0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40, // 박스의 가로 크기
                height: 40, // 박스의 세로 크기
                decoration: BoxDecoration(
                  color: Colors.white, // 박스의 배경색을 하얀색으로 설정
                  borderRadius:
                      BorderRadius.circular(8.0), // 박스의 모서리 반경을 8px로 설정
                ),
                padding: EdgeInsets.all(10.0), // 안쪽 여백을 20px로 설정
                child: Text(
                  '${sliderValue.toInt()}',
                  style: TextStyle(
                    fontSize: 15.0, // 텍스트 크기를 15px로 설정
                    color: Colors.black, // 텍스트 색상을 검정색으로 설정
                  ),
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬로 설정
                ), // 박스 안에 텍스트 추가
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Slider(
                  value: sliderValue,
                  onChanged: (value) {
                    vibrationBloc.changeIntensity(value);
                  },
                  min: 0,
                  max: 5,
                  divisions: 5,
                ),
              ),
            ],
          );
        });
  }
}
