import 'package:chuck_chu/deviceInformation.dart';
import 'package:chuck_chu/stretching_option_screens/stretching_time_page.dart';
import 'package:chuck_chu/stretching_option_screens/stretching_video_page.dart';
import 'package:chuck_chu/tap_page.dart';
import 'package:chuck_chu/yourube_url.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Colors.dart';

class StretchingPage extends StatefulWidget {
  @override
  _StretchingPageState createState() => _StretchingPageState();
}

class _StretchingPageState extends State<StretchingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceInformation = Provider.of<DeviceInformation>(context);
    Size size = MediaQuery.of(context).size;
    print('stretchingPage');
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(preferences.getString('date time'), style: TextStyle(fontSize: size.height / 15)),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  color: buttonColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimeSettingPage()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    '편집',
                    style: TextStyle(color: buttonTitleColor),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(right: size.width / 15, left: size.width / 15),
            child: Divider(
              thickness: 2,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: size.width / 3),
                  child: Text(
                    '스트레칭 컨텐츠',
                    style: TextStyle(fontSize: size.height / 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: size.width / 15, left: size.width / 15),
                    child: ListView.builder(
                      itemCount: youtubeUrl.length,
                      itemBuilder: (context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(youtubeUrl[index].title),
                            onTap: () async {
                              String url = youtubeUrl[index].url;
                              if(await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    color: buttonColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StretchingVideoPage()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      '더보기',
                      style: TextStyle(color: buttonTitleColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
