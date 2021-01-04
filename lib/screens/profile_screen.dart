import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // Colors.name[number] => number - alpha val
      body: SafeArea(
        //widget_SafeArea : 너무 위에 뭐가 있는 경우에 쓰는 ,, 레이아웃이 시간 배터리 부분 제외하고 시작하도록 해준다!
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //이걸로 widget 의 위치를 정해줄 수 있다 중앙(기본위치) 에서 원하는 곳으로!
          children: [
            _appbar(),
            ProfileBody(),//얘 제외 하고 나머지는 custom scroll view 로
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      //좌우 아이템 나열 이므로 row
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
          child: Text(
            'The Coding papa',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        )
      ],
    );
  }
}
