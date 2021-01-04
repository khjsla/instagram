//custom widget
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/widgets/rounded_avartar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime dateTime;

  Comment( //const 지워
      {
      Key key,
      this.showImage = true,
      @required this.username,
      @required this.text,
      this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (showImage) RoundedAvatar(size: 24),
        if (showImage)
          SizedBox(
            width: common_xxs_gap,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      //primary swatch 색을 따라가므로, 색을 따로 정해줘야함
                      text: username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87)),
                  TextSpan(text: ' '), //사이 공간
                  TextSpan(
                      text: text,
                      style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),
            if(dateTime != null)
            Text(
              dateTime.toIso8601String(),
              style: TextStyle(color: Colors.grey[400], fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
