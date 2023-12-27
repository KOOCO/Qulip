import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_mesurement_datamodel.dart';
import 'package:qulip/utils/dailog_helper.dart';
import 'package:path/path.dart' as Path;

class HorizontalCaseController extends BaseController {
  static HorizontalCaseController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final photoList = <String>[].obs;
  var finalList = <HorizontalDataModel>[].obs;

  Future<void> takePhoto(BuildContext context, int index) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath) async {
        if (filePath.isNotEmpty) {
          setLoading(true);
          debugPrint("FilePath $filePath");
          final uFile = File(filePath);
          uploadImage(uFile, index).then((url) {
            setLoading(false);
            finalList[index].imageUri = url;
            photoList[index] = url!;
            debugPrint("Himadri : Download url>> $index >>> $url");
          });
        }
      },
    );
  }

  Future<String?> uploadImage(File pickedImg, int index) async {
    var imageName =
        "${finalList[index].mesuringPoint!}_${DateTime.now().millisecondsSinceEpoch}";
    var ref = FirebaseStorage.instance
        .ref()
        .child('horizontal_survey')
        .child("$imageName.jpg");
    await ref.putFile(pickedImg);

    return await ref.getDownloadURL();
  }

  Future<void> deleteImage(String imageFileUrl) async {
    String fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(RegExp(r'(\?alt).*'), '');
    var ref = FirebaseStorage.instance.ref().child(fileUrl);

    await ref.delete();
  }

  Future<void> storeHorizontalFormData(List<HorizontalDataModel> list) async {
    setLoading(true);
    await createHorizontalForm(list);
  }

  createHorizontalForm(List<HorizontalDataModel> list) async {
    for (var i = 0; i < list.length; i++) {
      var currentElement = list[i];
      await _db
          .collection("horizontal_data")
          // .doc("Veritcal Form $number")
          .add(currentElement.toJson())
          .whenComplete(() {
        setLoading(false);
        photoList.clear();
      });
    }
  }
}
