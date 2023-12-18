import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_text.dart';

class MyFillButton extends StatelessWidget {
  const MyFillButton({
    super.key,
    this.text,
    //this.backGroundColor,
    this.fontSize = 16,
    this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String? text;
  final Function()? onPressed;
  final double? height;
  final double? fontSize;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(3),
          color: yasRed,
          boxShadow: const [
            BoxShadow(
              //spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1.5),
              color: Colors.black26,
            ),
          ],
        ),
        child: MyText(
          text ?? '',
          fontStyle: TextStyle(
            fontFamily: slashieFontFamily,
            color: stdBlack,
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
