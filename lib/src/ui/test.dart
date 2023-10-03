import 'package:flutter/material.dart';
import 'package:flutter_vibration_app_2/src/blocs/pattern_bloc.dart';
import 'package:flutter_vibration_app_2/src/models/pattern_model.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPatterns();
    return StreamBuilder(
        stream: bloc.allPatterns,
        builder: (context, AsyncSnapshot<List<PatternModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index].id),
                  onTap: () {
                    // 각 버튼을 탭했을 때 수행할 작업을 여기에 추가할 수 있습니다.
                    print('버튼 ${index + 1}을 탭했습니다.');
                  },
                );
              },
            );
          }

          return const Text('loading');
        });
  }
}
