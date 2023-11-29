import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/utils/text_style_helper.dart';

class BaseController extends GetxController {
  final isloading = false.obs;

  void setLoading(bool value) {
    if (value) {
      Get.dialog(
        barrierDismissible: false,
        Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: stdBlack.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: whiteTxt,
                    ),
                  ).paddingOnly(bottom: 10),
                  MyText(
                    'Loading...',
                    fontStyle: MyTextTheme14Normal.white(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      Get.back();
    }
  }
}
