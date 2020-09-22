import 'package:chuck_chu/main_pages/home_page.dar.dart';
import 'package:flutter/material.dart';

int index = 0;
List title = ['실시간 자세', '자세 기록', '스트레칭'];

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    print('tab page');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(title[index], style: TextStyle(color: Colors.black),),
        ),
      ),
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/bottom_icons/home_icon.png')),
            title: Text('현재 자세'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/bottom_icons/home_icon.png')),
            title: Text('현재 자세'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/bottom_icons/home_icon.png')),
            title: Text('현재 자세'),
          ),
        ],
      ),
    );
  }

  void onTapped(int value) {
    setState(() {
      index = value;
    });
  }
}
