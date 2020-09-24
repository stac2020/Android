import 'package:chuck_chu/Colors.dart';
import 'package:chuck_chu/database/Database_helper.dart';
import 'package:chuck_chu/main.dart';
import 'package:flutter/material.dart';

String name;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('내 정보'),
      ),
      body: FutureBuilder(
        future: DBHelper().getRank(),
        builder: (context, snapshot) {
          Widget rankIcon = Container();
          String title = '일반';
          if (snapshot.hasData) {
            if (80 < snapshot.data && snapshot.data < 120) {
              rankIcon = Image.asset("images/option_icons/rank_king_image.png");
              title = '킹';
            }
          }

          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Card(
                  color: profileColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.asset(
                                'images/option_icons/profile_basic_image.png'),
                            Padding(
                              child: IconButton(
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {},
                              ),
                              padding: EdgeInsets.only(top: 40, left: 40),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            rankIcon,
                            SizedBox(
                              width: 10,
                            ),
                            Text('척척추추'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('당신의 등급은 $title입니다.'),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
