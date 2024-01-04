import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_painter/image_painter.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_button_with_icon.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/utils/dailog_helper.dart';
import 'package:qulip/utils/datetime_helper.dart';

class CanvasHim extends StatelessWidget {
  CanvasHim({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();
  final _imageKey = GlobalKey<ImagePainterState>();
  var nfilePath = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: stdwhite,
          foregroundColor: yasRed,
          centerTitle: true,
          title: const MyText(
            WordStrings.surveyFormCreatelLbl,
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        backgroundColor: stdwhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.image,
                  color: yasRed,
                ),
                onPressed: () {
                  DialogBox.selectImage(
                    context,
                    onComplete: (filePath) async {
                      if (filePath.isNotEmpty) {
                        debugPrint("FilePath $filePath");
                        nfilePath.value = filePath;
                      }
                    },
                  );
                },
              ),
              Obx(() => ImagePainter.asset(
                    key: _imageKey,
                    (nfilePath.value.isEmpty)
                        ? "assets/images/profile.png"
                        : nfilePath.value,
                    scalable: false,
                    initialStrokeWidth: 2,
                    textDelegate: TextDelegate(),
                    initialColor: Colors.black,
                    initialPaintMode: PaintMode.line,
                  )),
            ],
          ),
        ));
  }
}
