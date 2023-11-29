import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final String image;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      color: color,
      height: height,
      width: width,
    );
  }
}
