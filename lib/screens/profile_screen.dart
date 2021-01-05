import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/widgets/profile_body.dart';
import 'package:instagram_two_record/widgets/profile_side_menu.dart';

const duration = Duration(milliseconds: 1000);
//class 밖에 있으면 다른 파일에서 접근 가능

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final duration = Duration(milliseconds: 300);
  final menuWidth = size.width/3*2;

  MenuStatus _menuStatus = MenuStatus.closed;

  double bodyXPos = 0;
  double menuXPos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        // Colors.name[number] => number - alpha val
        body: Stack(
          //Column to Stack
          children: [
            //Stack List 안의 순서가 중요하다! 얼마나 앞에 있게 되냐 아니냐 결정함
            AnimatedContainer(
              duration: duration,
              curve: Curves.fastOutSlowIn,
              child: ProfileBody( onMenuChanged: (){ //first
                setState(() {
                  _menuStatus = (_menuStatus == MenuStatus.closed)? MenuStatus.opened : MenuStatus.closed;

                  switch (_menuStatus) {
                    case MenuStatus.opened:
                    // TODO: Handle this case.
                      bodyXPos = -menuWidth;
                      menuXPos = size.width - menuWidth;
                      break;
                    case MenuStatus.closed:
                    // TODO: Handle this case.
                      bodyXPos = 0;
                      menuXPos = size.width;
                      break;
                  }

                });
              }),
              transform: Matrix4.translationValues( bodyXPos, 0, 0),
            ),
            AnimatedContainer(
              duration: duration,
              transform: Matrix4.translationValues( menuXPos, 0, 0),
              child: Positioned(
                //Positioned - MUST IN Stack!
                top: 0,
                bottom: 0,
                width: menuWidth,
                child: ProfileSideMenu(menuWidth),
              ),
            ),
          ],
        ) //싹다 옮겨버림
        );
  }
}

enum MenuStatus{ //not bool, but enum
  opened, closed
}