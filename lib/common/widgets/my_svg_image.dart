import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySVGImage extends StatelessWidget {
  const MySVGImage({Key? key, required this.image, this.height, this.width})
      : super(key: key);
  final String image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      height: height,
      width: width,
    );
  }
}
