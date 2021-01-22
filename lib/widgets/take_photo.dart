import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';

//make middle take photo page layout
class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //USE CONTAINER to set Color info and Size info
          width: size.width, //PER phoen size screen size
          height: size.width,
          color: Colors.black,
        ), //사진 찍는부분
        Expanded(
          /*   child: InkWell(
          onTap: () {}, //can Click for this
          child: Padding(
            padding: const EdgeInsets.all(common_s_gap),
            child: Container(
              //expanded -> 나머지 남은 부분 다 차지하게 한다
              decoration: ShapeDecoration(
                  shape: CircleBorder(
                      side: BorderSide(
                color: Colors.black12,
                width: 20,
              ))),
            ),
          ),
        ))*/ //방법1. BUT 버튼 부분만 눌리는게 아니라 사진 촬영하는 부분을 제외한 모든 부분들이 버튼이 되는 것 같은 현상이 나타난다.
          child: OutlineButton(
            onPressed: () {},
            shape: CircleBorder(),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 20,
            ), //방법1. 이게 일반적으로 버튼을 삽입할떄 쓰이는 코드이다. 이제 버튼만이 버튼의 역할을 하는 것 처럼 보이게 된다.
          ),
        )
      ],
    );
  }
}
