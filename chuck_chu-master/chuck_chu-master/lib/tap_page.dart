import 'dart:typed_data';

import 'package:chuck_chu/database/Database_helper.dart';
import 'package:chuck_chu/optoin_screens/inquire_page.dart';
import 'package:chuck_chu/optoin_screens/profile_page.dart';
import 'package:chuck_chu/optoin_screens/setting_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Colors.dart';
import 'database/record.dart';
import 'deviceInformation.dart';
import 'main_screens/home_page.dart';
import 'main_screens/recording_page.dart';
import 'main_screens/stretching_page.dart';

BluetoothDevice bluetoothDevice;
bool isConnected = false;
BluetoothConnection _connection;
List _screen = [HomePage(), RecordingPage(), StretchingPage()];
List _appBarTitle = ['실시간 자세', '자세 기록', '스트레칭'];
String _infoMessage = '추가된 디바이스가 없습니다.';
String _imagePath = 'images/position_icons/normalIcon.png';
BluetoothState bluetoothState = BluetoothState.UNKNOWN;
SharedPreferences preferences;
String dateTimeString;
DateTime dateTime;
double sum = 0;
int count = 0;

class TapPage extends StatefulWidget {
  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSharedPreference();
    dateTime = DateTime.now();

    if (bluetoothDevice != null) {
      print('bluetooth - ${bluetoothDevice.name}');

      BluetoothConnection.toAddress(bluetoothDevice.address).then((value) {
        print('connected bluetooth');
        _connection = value;
        _connection.input.listen(_onDataReceive).onDone(() {
          print('input bluetooth value');
        });
      }).catchError((onError) {
        print('$onError');
      });
      isConnected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceInformation = Provider.of<DeviceInformation>(context);
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_infoMessage != deviceInformation.getTitle()) {
        deviceInformation.setMessage(_infoMessage);
      }

      if (_imagePath != deviceInformation.getImage()) {
        deviceInformation.setImage(_imagePath);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Center(
          child: Text(_appBarTitle[deviceInformation.getIndex()]),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async{
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ));

              setState(() {
                
              });
            },
            icon: ImageIcon(AssetImage('images/option_icons/settingIcon.png')),
          )
        ],
      ),
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Drawer(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Menu',
                    style: TextStyle(fontSize: height / 15),
                  ),
                ),
                ListTile(
                  title: Text('내 정보'),
                  leading: ImageIcon(
                    AssetImage('images/option_icons/profileIcon.png'),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ));
                  },
                ),
                Expanded(
                  child: SizedBox(),
                ),
                ListTile(
                  title: Text('설정'),
                  leading: ImageIcon(
                    AssetImage('images/option_icons/settingIcon.png'),
                  ),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ));

                    setState(() {

                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: _screen[deviceInformation.getIndex()],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColor,
        onTap: (value) {
          deviceInformation.setIndex(value);
        },
        currentIndex: deviceInformation.getIndex(),
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/bottom_icons/homeIcon.png')),
            title: Text('현재 자세'),
          ),
          BottomNavigationBarItem(
            icon:
                ImageIcon(AssetImage('images/bottom_icons/recordingIcon.png')),
            title: Text('현재 자세'),
          ),
          BottomNavigationBarItem(
            icon:
                ImageIcon(AssetImage('images/bottom_icons/stretchingIcon.png')),
            title: Text('현재 자세'),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  void _onDataReceive(Uint8List data) {
    int backspacesCounter = 0;
    String receiveData;

    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });

    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    backspacesCounter = 0;

    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    receiveData = String.fromCharCodes(buffer);

    if (receiveData.endsWith('\r')) {
      double anagle;
      receiveData = receiveData.replaceAll('\n\r', '');
      int time;

      try {
        anagle = double.parse(receiveData);
      } on FormatException {
        anagle = null;
      }

      if (anagle != null && anagle > 0) {
        sum += anagle;
count++;
        if (80 < anagle && anagle < 120) {
          _infoMessage = '좋은 자세를 유지하고 있습니다.';
          _imagePath = 'images/position_icons/good_position.png';
        } else {
          _infoMessage = '나쁜 자세를 유지하고 있습니다.';
          _imagePath = 'images/position_icons/bad_position.png';
        }

        if ((time = dateTime.difference(DateTime.now()).inMinutes) < 0) {
          time *= -1;
        }

        if (time >= 30) {
          double avg;

          dateTime = DateTime.now();

          avg = sum / count;

          Record record = Record(
              id: 0,
              record: avg.toStringAsFixed(2),
              date: formatDate(dateTime, [mm, '월', dd, '일\n', HH, '시', nn, '분']));
          DBHelper().createData(record);

          sum = 0;
          count = 0;
        }

        setState(() {});
      }
    }
  }

  void setSharedPreference() async {
    preferences = await SharedPreferences.getInstance();

    preferences.setString(
        'date time', formatDate(DateTime.now(), [HH, '시간', nn, '분']));

    preferences.setString('realTime', dateTime.toString());
  }
}
