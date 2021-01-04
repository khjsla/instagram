//파일 옮길때 그냥 옮기면 안됨 우클 해서 refactor 로 옮기기
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/widgets/post.dart'; //import my function

class FeedScreen extends StatelessWidget { //stl -> statelessWidget 바로
  @override
  Widget build(BuildContext context) {
    return Scaffold( //material app 에서 자주 사용되는 animation 들을 모아둔 것
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.camera_alt,color: Colors.black87,),
        ),
        middle: Text(
          'instagram',
          style: TextStyle(
            fontFamily: 'VeganStyle',
            color: Colors.black87
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, //main axis 크기를 min으로 정하겟다.
          children: <Widget>[
            IconButton(
              onPressed: null, //click event null
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              )
            ),
            IconButton(
              onPressed: null, //click event null
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              )
            )
          ],
        ),
      ),
      body: ListView.builder(itemBuilder: feedListBuilder, itemCount: 30,) //item 30개
    );
  }

  //return Widget
  //각 부분에 뭐가 들어가는지 설정해줌
  Widget feedListBuilder(BuildContext context, int index){ //function 자체를 위의 body 에 던져줌
    return Post(index); //Refactor ->
  }
}



//List - scroll 가능  vs colmn , row  - scroll 불가
