import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/dailog_helper.dart';

class VerticalCanvas2 extends StatefulWidget {
  const VerticalCanvas2({super.key});

  @override
  State<VerticalCanvas2> createState() => _VerticalCanvas2State();
}

class _VerticalCanvas2State extends State<VerticalCanvas2> {
  final controller = Get.put(EstablishCaseController());

  DateTime sDate = DateTime.now();

  final _imageKey = GlobalKey<ImagePainterState>();
  final _fileImageKey = GlobalKey<ImagePainterState>();

  XFile? file;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EstablishCaseController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: stdwhite,
          foregroundColor: yasRed,
          centerTitle: true,
          title: MyText(
            "${controller.txtCaseName.text}_${WordStrings.surveyFormVerticallLbl}",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        backgroundColor: stdwhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        color: yasRed,
                      ),
                      onPressed: () {
                        DialogBox.selectImage(
                          context,
                          onComplete: (filePath, xFile) async {
                            if (filePath.isNotEmpty) {
                              debugPrint("FilePath $filePath");
                              setState(() {
                                file = xFile;
                              });
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: yasRed,
                      ),
                      onPressed: () {
                        setState(() {
                          file = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: file == null
                    ? ImagePainter.asset(
                        height: MediaQuery.of(context).size.height * 0.7,
                        key: _imageKey,
                        "assets/images/white_image.jpg",
                        scalable: false,
                        initialStrokeWidth: 2,
                        textDelegate: TextDelegate(),
                        initialColor: Colors.black,
                        initialPaintMode: PaintMode.rect,
                      )
                    : ImagePainter.file(
                        key: _fileImageKey,
                        File(file!.path),
                        scalable: true,
                        initialStrokeWidth: 2,
                        textDelegate: TextDelegate(),
                        initialColor: Colors.black,
                        initialPaintMode: PaintMode.rect,
                      ),
              ),
              MyButton(
                label: WordStrings.nextLbl,
                style: const TextStyle(
                  color: whiteTxt,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const BoxDecoration(
                  color: yasRed,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black54,
                    )
                  ],
                ),
                height: Get.height * 0.05,
                borderRadius: 2,
                onTap: () async {
                  controller.setLoading(true);
                  saveImage().then((value) {
                    controller.setLoading(false);
                    controller.canvasVertical2Url.value = value!;
                    setState(() {
                      file = null;
                    });
                    Get.toNamed(AppRoutes
                        .horizontalCanvasView);
                  });
                },
              ).paddingOnly(top: 30.h).paddingSymmetric(horizontal: 14.w)
            ],
          ),
        ));
  }

  Future<String?> saveImage() async {
    if (_imageKey.currentState != null) {
      final data = await _imageKey.currentState!.exportImage();
      final tempDir = await getApplicationDocumentsDirectory();
      File file = File(
          "${tempDir.path}/VM_CANVAS_2${DateTime.now().millisecondsSinceEpoch}.png");

      debugPrint("Test >> Path $data");
      if (data != null) {
        file.writeAsBytesSync(data);

        var ref = FirebaseStorage.instance
            .ref()
            .child('canvas')
            .child("VM_CANVAS_2${DateTime.now().millisecondsSinceEpoch}.png");
        await ref.putFile(file);
        return await ref.getDownloadURL();
      }
    } else {
      final data = await _fileImageKey.currentState!.exportImage();
      final tempDir = await getApplicationDocumentsDirectory();
      File file = File(
          "${tempDir.path}/VM_CANVAS_2${DateTime.now().millisecondsSinceEpoch}.png");

      debugPrint("Test >> Path $data");
      if (data != null) {
        file.writeAsBytesSync(data);

        var ref = FirebaseStorage.instance
            .ref()
            .child('canvas')
            .child("VM_CANVAS_2${DateTime.now().millisecondsSinceEpoch}.png");
        await ref.putFile(file);
        return await ref.getDownloadURL();
      }
    }
    return null;
  }
}
