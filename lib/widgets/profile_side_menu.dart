import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/screen_size.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  const ProfileSideMenu(this.menuWidth, {Key key})
      : super(key: key); //{}안은 option 밖은 필수 입력

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        //이 위젯아래의 최종 사이즈를 지정
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                title: Text('Setting',style: TextStyle(
                  fontWeight: FontWeight.bold
                ) ,))
            ,
            ListTile(
                //?
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black87,
                ),
                title: Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
