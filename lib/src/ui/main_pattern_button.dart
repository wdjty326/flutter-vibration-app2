import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';

class MainPatternButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            backgroundColor: MaterialStateProperty.all(Colors.pink), // 분홍색 배경
            textStyle: MaterialStateProperty.all(
                TextStyle(color: Colors.black)), // 텍스트 색상
          ),
          child: Text(isVibrate ? 'stop' : 'start'),
        );
      },
    );
  }
}
