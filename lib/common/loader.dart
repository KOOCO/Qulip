import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';

class MyCircularLoader extends StatelessWidget {
  const MyCircularLoader({Key? key, this.color = yasRed}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: 2,
    );
  }
}
