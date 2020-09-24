import 'package:chuck_chu/Colors.dart';
import 'package:chuck_chu/deviceInformation.dart';
import 'package:chuck_chu/tap_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';

DateTime _dateTime;

class TimeSettingPage extends StatefulWidget {
  @override
  _TimeSettingPageState createState() => _TimeSettingPageState();
}

class _TimeSettingPageState extends State<TimeSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceInformation = Provider.of<DeviceInformation>(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('시간 설정'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: TimePickerSpinner(
              onTimeChange: (value) {
                print(value);
                _dateTime = value;
              },
            ),
          ),
          SizedBox(
            height: height / 4,
          ),
          RaisedButton(
              onPressed: () {
                print(_dateTime);
                deviceInformation.setDateTime(_dateTime);
                preferences.setString('date time', deviceInformation.getDateTime());
                print(deviceInformation.getDateTime());
                print(preferences.getString('date time'));
                Navigator.pop(context);
              },
              child: Text(
                '저장',
                style: TextStyle(color: buttonTitleColor),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: buttonColor
          ),
        ],
      ),
    );
  }
}