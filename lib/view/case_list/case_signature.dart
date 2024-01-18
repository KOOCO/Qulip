import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/controller/case_list_controller.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var caseId = Get.arguments;
    final controller = Get.find<CaseListController>();
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: stdwhite,
          // foregroundColor: yasRed,
          // centerTitle: true,
          // title: const MyText(
          //   WordStrings.signatureLbl,
          //   fontFamily: FontFamilyConstant.sinkinSans,
          //   fontSize: 18,
          //   fontColor: yasRed,
          // ),
          ),
      backgroundColor: stdwhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: SfSignaturePad(
              key: signatureGlobalKey,
              backgroundColor: Colors.white,
              strokeColor: yasRed,
              minimumStrokeWidth: 1.0,
              maximumStrokeWidth: 4.0,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyButton(
                label: WordStrings.btnSaveLbl,
                style: const TextStyle(
                  color: whiteTxt,
                  fontWeight: FontWeight.bold,
                ),
                height: Get.height * 0.05,
                width: Get.width * 0.2,
                borderRadius: 2,
                onTap: () {
                  controller.setLoading(true);
                  handleSaveButtonPressed(context).then((url) {
                    controller.setSignature(caseId, url!);
                    Get.back();
                  });
                },
              )..paddingOnly(left: 4, right: 4),
              MyButton(
                label: WordStrings.clearImg,
                style: const TextStyle(
                  color: whiteTxt,
                  fontWeight: FontWeight.bold,
                ),
                height: Get.height * 0.05,
                width: Get.width * 0.2,
                borderRadius: 2,
                onTap: () {
                  _handleClearButtonPressed();
                },
              )..paddingOnly(left: 4, right: 4),
            ],
          )
        ],
      ),
    );
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  Future<String?> handleSaveButtonPressed(BuildContext context) async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    final tempDir = await getApplicationDocumentsDirectory();
    File file =
        File("${tempDir.path}/SN_${DateTime.now().millisecondsSinceEpoch}.png");

    final file1 =
        await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);

    var ref = FirebaseStorage.instance
        .ref()
        .child('signature')
        .child("SN_${DateTime.now().millisecondsSinceEpoch}.png");
    await ref.putFile(file1);
    return await ref.getDownloadURL();
  }
}
