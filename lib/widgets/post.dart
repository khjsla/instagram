
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';

class Post extends StatelessWidget {
  final int index;
  //final - 변경 불가한 변수
  Size size;

  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(size == null){
      size = MediaQuery.of(context).size;
    }
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/2000/2000', //사이에 index 값 끼워넣어서 random 이미지 생성
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