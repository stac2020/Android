import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Colors.dart';

class DeviceInformation extends ChangeNotifier {
  BluetoothDevice _bluetoothDevice;
  String _message = '추가된 디바이스가 없습니다.';
  String _image = 'images/position_icons/normalIcon.png';
  int _index = 0;
  String _dateTime = formatDate(DateTime.now(), [HH, '시간', nn, '분']);

  DeviceInformation(this._bluetoothDevice);

  BluetoothDevice getBluetoothDevice() {
    return _bluetoothDevice;
  }

  bool getIsConnected() {
    if (_bluetoothDevice != null) {
      return _bluetoothDevice.isConnected;
    } else
      return false;
  }

  String getTitle() {
    return _message;
  }

  String getImage() {
    return _image;
  }

  int getIndex() {
    return _index;
  }

  String getDateTime() {
    return _dateTime;
  }

  void setBluetoothDevice(BluetoothDevice bluetoothDevice) {
    _bluetoothDevice = bluetoothDevice;
    notifyListeners();
  }

  void setMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setImage(String newImage) {
    _image = newImage;
    notifyListeners();
  }

  void setDateTime(DateTime dateTime) {
    _dateTime = formatDate(dateTime, [HH, '시간', nn, '분']);
    notifyListeners();
  }

  void setBrightColor() {
    textColor = Colors.black;
    iconColor = Colors.black;
    appColor = Colors.white;
    cardColor = Colors.grey[300];
    buttonTitleColor = Colors.white;
    profileColor = Colors.white;
    settingButtonColor = Colors.white;
    backgroundColor = Colors.white;
    notifyListeners();
  }


}
