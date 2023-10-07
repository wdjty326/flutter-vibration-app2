import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/pattern_bloc.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';
import 'package:flutter_vibration_app_2/src/company_colors.dart';
import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';

class MainPatternList extends StatelessWidget {
  const MainPatternList({super.key});

  @override
  Widget build(BuildContext context) {
    /// 데이터 가져오기
    patternBloc.fetchAllPatterns();

    return Expanded(
        child: StreamBuilder(
            stream: patternBloc.allPatterns,
            builder: (context, AsyncSnapshot<List<PatternModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  itemBuilder: (BuildContext context, int index) {
                    var item = snapshot.requireData[index];
                    return OutlinedButton(
                      onPressed: () {
                        vibrationBloc.changePattern(item);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            CompanyColors.taffy), // 분홍색 배경
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white)), // 텍스트 색상
                      ),
                      child: Text(
                        item.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              }

              return const Text('loading');
            }));
  }
}
