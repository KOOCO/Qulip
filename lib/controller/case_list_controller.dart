import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:flutter/material.dart';

class CaseListController extends BaseController {
  static CaseListController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> getData() async {
    final cRef = _db.collection('/case_survey');
    QuerySnapshot querySnapshot = await cRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    debugPrint("Himadri:  " + allData.toList().toString());
  }
}
