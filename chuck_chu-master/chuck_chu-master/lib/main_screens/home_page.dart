import 'package:chuck_chu/Colors.dart';
import 'package:chuck_chu/deviceInformation.dart';
import 'package:chuck_chu/optoin_screens/bluetooth_page.dart';
import 'package:flutter/material.dart';
import 'package:chuck_chu/tap_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    print('homepage initState');
  }

  @override
  Widget build(BuildContext context) {
    final deviceInformation = Provider.of<DeviceInformation>(context);
    print('homePage');
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(deviceInformation.getImage()),
                  SizedBox(
                    height: 20,
                  ),
                  Text(deviceInformation.getTitle(), style: TextStyle(color: textColor),),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(50),
                child: Card(
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('내 디바이스'),
                        ),
                        Center(
                            child: _bluetoothDeviceWidget(context)),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bluetoothDeviceWidget(BuildContext context) {
    Widget widget;
    if (isConnected) {
      print('set image');
      widget = Image.asset('images/option_icons/bluetoothDevice.png');
    } else {
      print('set iconbutton');
      widget = IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BluetoothPage(),
              ));
        },
        icon: Icon(Icons.add),
      );
    }

    return widget;
  }
}
