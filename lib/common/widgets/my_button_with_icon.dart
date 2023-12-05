import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_animation_button.dart';
import 'package:qulip/common/widgets/my_image.dart';

class MyButtonWithIcon extends StatelessWidget {
  const MyButtonWithIcon({
    Key? key,
    required this.label,
    required this.onTap,
    this.height,
    this.width,
    this.bgColor = yasRed,
    this.borderColor = yasRed,
    this.borderRadius = 10,
    this.style,
    this.decoration,
    this.image,
  }) : super(key: key);
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Color bgColor;
  final Color borderColor;
  final String label;
  final double borderRadius;
  final TextStyle? style;
  final BoxDecoration? decoration;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return CLBounceWidget(
      onPressed: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(2),
            ),
        alignment: Alignment.center,
        child: buildChild(),
      ),
    );
  }

  Widget buildChild() {
    return Row(
      children: [
        MyImage(
          image: image ?? AssetImages.userLogo,
          width: 25.w,
          height: 25.h,
          color: bgColor,
        ).paddingAll(8),
        Expanded(
          child: Center(
            child: Text(
              label,
              style: style,
            ),
          ),
        ),
      ],
    );
  }
}
