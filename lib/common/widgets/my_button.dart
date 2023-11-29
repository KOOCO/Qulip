import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_animation_button.dart';

class MyButton extends StatelessWidget {
  const MyButton({
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
    // if (controller.isloading.value) {
    //   return const MyCircularLoader(
    //     color: whiteTxt,
    //   );
    // } else {
    return Text(
      label,
      style: style,
    );
  }
  // }
}
