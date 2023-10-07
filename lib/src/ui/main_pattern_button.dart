import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';
import 'package:flutter_vibration_app_2/src/company_colors.dart';

class MainPatternButton extends StatelessWidget {
  const MainPatternButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: vibrationBloc.isVibrate,
      builder: (context, snapshot) {
        var isVibrate = snapshot.hasData ? snapshot.requireData : false;
        return StreamBuilder(
            stream: vibrationBloc.selectPattern,
            builder: (context2, snapshot2) {
              var selectPattern = snapshot2.data;
              return OutlinedButton(
                onPressed: selectPattern == null
                    ? null
                    : () {
                        debugPrint('@vibrationBloc: isVibrate $isVibrate');
                        if (isVibrate) {
                          vibrationBloc.stopVibration();
                          return;
                        }
                        vibrationBloc.startVibration();
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      selectPattern == null
                          ? CompanyColors.blush
                          : CompanyColors.taffy), // 분홍색 배경
                ),
                child: Text(isVibrate ? '정지' : '시작',
                    style: const TextStyle(color: Colors.white)),
              );
            });
      },
    );
  }
}
