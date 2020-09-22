import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/position/normal_position.png',
                    width: size.width / 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('연결된 디바이스가 없습니다.'),
                ],
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.grey[100],
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: SizedBox(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Stack(
                      children: <Widget>[
                        Text('내 디바이스'),
                        Center(
                          child: FlatButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add),
                                Text('디바이스 추가')
                              ],
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
