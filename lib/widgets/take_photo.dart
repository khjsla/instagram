import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';

//make middle take photo page layout
class TakePhoto extends StatefulWidget {
  //stl -> stf
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(), //user 사용하는 카메
        builder: (context, snapshot) {
          //if (!snapshot.hasData)
          //  return MyProgressIndicator();
          return Column(
            children: [
              Container(
                //USE CONTAINER to set Color info and Size info
                width: size.width, //PER phoen size screen size
                height: size.width,
                color: Colors.black,
                child:
                    (snapshot.hasData) ? _getPreview(snapshot.data) : _progress,
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
        });
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    //to show preview
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    //_controller.initialize();
    return FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRect(
              // 이 위젯을 통해 정사각형으로 잘라준다
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                      width: size.width,
                      height: size.width / _controller.value.aspectRatio,
                      child: CameraPreview(_controller)),
                ),
              ),
            );
          } else {
            return _progress;
          }
        });
  }
}
