import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  final double containerSize; //underline - make ..
  final double progressSize;

  const MyProgressIndicator({Key key, this.containerSize, this.progressSize = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: containerSize,
        height: containerSize,
        child: Center(
            child: SizedBox(
                height: progressSize,
                width: progressSize,
                //loading gif 파일중 원하는 것 가져와서 
                child: Image.asset('assets/images/loading_img.gif'))));
  }
}
