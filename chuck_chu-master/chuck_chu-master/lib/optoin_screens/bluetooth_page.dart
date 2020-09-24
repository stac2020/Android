import 'package:chuck_chu/deviceInformation.dart';
import 'package:chuck_chu/main.dart';
import 'package:chuck_chu/tap_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import '../Colors.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool ignoring = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _deviceList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterBluetoothSerial.instance.state.then((state) {
      print('state : $state');
      setState(() {
        _bluetoothState = state;
      });
    });

    enableBluetooth();

    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      setState(() {
        _bluetoothState = state;
        getPairedDevice();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothDevice = Provider.of<DeviceInformation>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('기기 등록'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bluetooth),
            onPressed: () => FlutterBluetoothSerial.instance.openSettings(),
          )
        ],
      ),
      body: _getDeviceItem(bluetoothDevice, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Device list refreshed !'),
            duration: Duration(seconds: 3),
          ));
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<void> enableBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    print("$_bluetoothState");
    if (_bluetoothState == BluetoothState.STATE_ON) {
      await FlutterBluetoothSerial.instance.requestDisable();
      await getPairedDevice();

      return true;
    } else {
      await getPairedDevice();
    }

    return false;
  }

  Future<void> getPairedDevice() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await _bluetoothSerial.getBondedDevices();
    } on PlatformException {
      print('Error');
    }

    if (mounted) {
      setState(() {
        _deviceList = devices;
      });
    }
  }

  _getDeviceItem(DeviceInformation bluetooth, BuildContext context) {
    if (_bluetoothState == BluetoothState.STATE_ON) {
      if (_deviceList.isEmpty) {
        return Center(child: Text('블루투스를 찾을 수 없음'));
      } else {
        return ListView.builder(
            itemCount: _deviceList.length,
            itemBuilder: (cxt, int index) {
              return ListTile(
                title: Text(_deviceList[index].name),
                onTap: () {
                  bluetooth.setBluetoothDevice(_deviceList[index]);
                  bluetoothDevice = bluetooth.getBluetoothDevice();
                  print('bluetoothDevice value - ${bluetoothDevice.name}');
                  print('bluetoothDevice value - ${bluetoothDevice.address}');
                  print('bluetooth page pop !');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (route) => false);
                },
              );
            });
      }
    } else if (_bluetoothState == BluetoothState.STATE_OFF) {
      return Center(
        child: Text('블루투스가 꺼져있습니다.'),
      );
    }
  }
}
