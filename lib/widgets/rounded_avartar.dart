//custom widget
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {
  final double size;

  const RoundedAvatar({
    Key key,
    this.size = avatar_size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      //widget으로 감싸고, 이름을 ClipOval로 바꿈. 동그랗게 하기위해
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/100',
        width: size,
        height: size,
      ),
    );
  }
}