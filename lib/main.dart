import 'package:flutter/material.dart'; //for google
import 'package:instagram_two_record/constants/meterial_white.dart';
import 'package:instagram_two_record/screens/auth_screen.dart';
//import 'package:flutter/cupertino.dart'; //for ios

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: AuthScreen(),
      ///home: HomePage(),
      theme: ThemeData( //app 전체에 적용을 해주고 싶으면 여기 main 에서 설정을 해줘야 한다.
        primarySwatch: white
      ),
    );
  }
}

