import 'package:bezier_chart/bezier_chart.dart';
import 'package:chuck_chu/database/Database_helper.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';

class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: DBHelper().getAllData(),
        builder: (context, snapshot) {
          List list = [];
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.length; i++) {
              var data = snapshot.data[i];
              String record = data['record'];
              String date = data['date'];
              list.add([record, date]);
            }
            return LineChart(
              chartPadding: EdgeInsets.all(40),
              lines: [
                new Line(
                  data: list,
                  xFn: (datum) => datum[1],
                  yFn: (datum) => datum[0],
                ),
              ],
            );
          } else {
            return Center(
              child: Text('기록된 자세가 없습니다.'),
            );
          }
        },
      ),
    );
  }
}

class Data {
  final int record;
  final String dateTime;

  Data({this.record, this.dateTime});
}
