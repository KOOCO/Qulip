import 'package:flutter/material.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    Key? key,
    this.fontSize = 14,
    this.maxLines = 4,
    this.fontStyle,
    this.fontFamily = FontFamilyConstant.sinkinSans,
    this.fontColor = stdBlack,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color? fontColor;
  final TextStyle? fontStyle;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: fontStyle ??
          TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: fontColor,
            fontWeight: fontWeight,
            decoration: decoration,
          ),
    );
  }
}
