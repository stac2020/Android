import 'package:chuck_chu/yourube_url.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StretchingVideoPage extends StatefulWidget {
  @override
  _StretchingVideoPageState createState() => _StretchingVideoPageState();
}

class _StretchingVideoPageState extends State<StretchingVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스트레칭 컨텐츠'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
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
    );
  }
}
