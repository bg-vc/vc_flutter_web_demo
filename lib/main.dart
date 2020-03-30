import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vc_flutter_web_demo/pages/about_page.dart';
import 'package:vc_flutter_web_demo/pages/archive_page.dart';
import 'package:vc_flutter_web_demo/pages/friend_link_page.dart';
import 'package:vc_flutter_web_demo/pages/home_page.dart';
import 'package:vc_flutter_web_demo/pages/tag_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'The Web Of Vince Chen',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => HomePage(),
        "/tag": (BuildContext context) => TagPage(),
        '/archive': (BuildContext context) => ArchivePage(),
        "/link": (BuildContext context) => FriendLinkPage(),
        "/about": (BuildContext context) => AboutPage(),
      },
    );
  }
}
