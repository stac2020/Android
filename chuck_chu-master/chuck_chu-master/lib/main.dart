import 'package:chuck_chu/deviceInformation.dart';
import 'package:chuck_chu/tap_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp');
    return ChangeNotifierProvider<DeviceInformation>(
      create: (_) => DeviceInformation(null),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                title: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: iconColor),
              color: appColor,
            ),
            primaryColor: primaryColor,
          ),
          home: TapPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
