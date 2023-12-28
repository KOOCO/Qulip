import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';

class CaseListController extends BaseController {
  static CaseListController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  List caseList = [];
  var caseListNew = <EstablishCaseModel>[].obs;

  Future<List> getData() async {
    await _db.collection('/case_survey').get().then((value) {
      final result = (value.docs)
          .map((x) => EstablishCaseModel.fromJson(x.data()))
          .toList();
      caseListNew.addAll(result);
      debugPrint("Himadri :: ${caseListNew.length}");
    });

    return caseList;
    // final cRef = _db.collection('/case_survey');
    // QuerySnapshot querySnapshot = await cRef.get();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // debugPrint("Himadri :: ${allData.length}");
  }
}
