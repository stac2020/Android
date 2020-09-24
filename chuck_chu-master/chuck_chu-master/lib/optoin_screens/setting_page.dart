import 'package:chuck_chu/Colors.dart';
import 'package:chuck_chu/database/Database_helper.dart';
import 'package:chuck_chu/deviceInformation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceInformation = Provider.of<DeviceInformation>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: settingButtonColor,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('기록 삭제'),
                ),
              ),
              onPressed: () => DBHelper().deleteAllData(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            )
          ],
        ),
      ),
    );
  }
}
