import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/pattern_bloc.dart';
import 'package:flutter_vibration_app_2/src/blocs/vibration_bloc.dart';
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
                  itemBuilder: (BuildContext context, int index) {
                    var item = snapshot.requireData[index];
                    return Container(
                      color: Colors.white, // 하얀색 배경
                      child: ElevatedButton(
                        onPressed: () {
                          vibrationBloc.changePattern(item);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink), // 분홍색 배경
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white)), // 텍스트 색상
                        ),
                        child: Text(item.name),
                      ),
                    );
                  },
                );
              }

              return Text('loading');
            }));
  }
}
