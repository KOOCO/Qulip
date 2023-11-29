import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: yasRed,
      leadingWidth: Get.width * 0.085,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        tooltip: 'Back Icon',
        onPressed: () {},
      ),
    );
  }
}
