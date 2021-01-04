
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/widgets/comment.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';
import 'package:instagram_two_record/widgets/rounded_avartar.dart'; //Make Widget -> 1. option+command+W 2.make dartfile 3.import ..

class Post extends StatelessWidget {
  final int index;
  //final - 변경 불가한 변수

  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(//column 으로 감쌈
      crossAxisAlignment: CrossAxisAlignment.start, //맨 왼쪽으로
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }

  Widget _postCaption(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap), //padding
      child: Comment(
        showImage: false,
        username: 'testingUser',
        text: 'I have money',
      ), //custom widget
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text('12000 likes', style: TextStyle(fontWeight: FontWeight.bold),),
      );
  }

  Row _postActions() { //post action 대한 method 정리
    return Row(
        children: <Widget>[
          IconButton(
            onPressed: null, //have to insert this (on press)
            icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: null, //have to insert this (on press)
            icon: ImageIcon(AssetImage('assets/images/comment.png')),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: null, //have to insert this (on press)
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black87,
          ),
          Spacer(), //button 사이의 남는 자리를 얘가 다 차지해준다
          IconButton(
            onPressed: null, //have to insert this (on press)
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
            color: Colors.black87,
          )
        ],
      );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding( //widget 간 겹치지 않게 padding
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ), // imageUrl ../100 - wid,hei 100 정사각형
        Expanded(child: Text('username')), //남은 나머지 자리를 차지하게 해주는 widget - Expanded
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() { //option,command+M - refactor
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/200', //사이에 index 값 끼워넣어서 random 이미지 생성
        placeholder: (BuildContext context, String url){
            return MyProgressIndicator( containerSize: size.width,); //여기서 크기 명시 안하면 mpi 에서 설정한 default 값인 60이 설정된다
          },//image 로딩되는 동안 보여즐 것
        imageBuilder: (BuildContext context, ImageProvider imageProvider){
          return AspectRatio(
            aspectRatio: 1, //가로세로 비율 1 ,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:  imageProvider,
                  fit: BoxFit.cover //이미지가 해당 컨테이너 안에 어떻게 들어가게 되는가 에대한 옵션
                )
              ),
            ),
          );
      }
      );
  }
}



