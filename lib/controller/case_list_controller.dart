import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qulip/apis/api_repository.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';

class CaseListController extends BaseController {
  static CaseListController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //List caseList = [];
  var caseListNew = <EstablishCaseModel>[].obs;
  var isProcessComplete = false;
  final isPDFExported = false.obs;
  final signUrl = "".obs;
  final pdfUrl = "".obs;

  Future getData() async {
    // setLoading(true);
    await _db
        .collection('case_survey')
        .orderBy('createdAt', descending: false)
        .get()
        .then((value) {
      final result = (value.docs)
          .map((x) => EstablishCaseModel.fromJson(x.data()))
          .toList();
      caseListNew.clear();
      caseListNew.addAll(result);
    }).whenComplete(() => isProcessComplete = true);
  }

  Future filterData(String selectedFilter) async {
    DateTime now = DateTime.now();
    var now_6m = DateTime(now.year, now.month - 6, now.day);
    var now_3m = DateTime(now.year, now.month - 3, now.day);

    if (selectedFilter == WordStrings.sixMonthLbl) {
      // List of before 6 months from now

      await _db
          .collection('case_survey')
          .orderBy('createdAt', descending: false)
          .get()
          .then((value) {
        final result = (value.docs)
            .map((x) => EstablishCaseModel.fromJson(x.data()))
            .toList();
        caseListNew.clear();
        caseListNew.addAll(result);
      }).whenComplete(() {
        isProcessComplete = true;

        var filteredList = caseListNew.where((caseItem) {
          DateTime? cDate = caseItem.createdAt;
          // debugPrint(
          //     "Six month before >> ${caseItem.createdAt} >> ${cDate!.isBefore(now_6m)}  >> $now_6m");
          return cDate!.isBefore(now_6m);
        }).toList();
        // debugPrint("Six month before >> ${filteredList.toString()}");

        caseListNew.clear();
        caseListNew.addAll(filteredList);
      });
    } else if (selectedFilter == WordStrings.threeMonthLbl) {
      await _db
          .collection('case_survey')
          .orderBy('createdAt', descending: false)
          .get()
          .then((value) {
        final result = (value.docs)
            .map((x) => EstablishCaseModel.fromJson(x.data()))
            .toList();
        caseListNew.clear();
        caseListNew.addAll(result);
      }).whenComplete(() {
        isProcessComplete = true;

        var filteredList = caseListNew.where((caseItem) {
          DateTime? cDate = caseItem.createdAt;
          // debugPrint(
          //     "Three month before >> ${caseItem.createdAt} >> ${cDate!.isBefore(now_3m)} >> $now_3m");
          return cDate!.isBefore(now_3m);
        }).toList();

        caseListNew.clear();
        caseListNew.addAll(filteredList);
      });
    } else {
      getData();
    }
  }

  Future<bool> getPoints(String mobile, String caseId) async {
    setLoading(true);
    ApiRepo.getPoints(
      phone: mobile,
      onComplete: (success, response) async {
        setLoading(false);
        if (success) {
          // isExportUpdate(caseId);
          // MySnackBar.successSnackbar(response['message']);
          return true;
        } else {
          setLoading(false);
          return false;
        }
      },
    );
    return false;
  }

  void setSignature(String caseId, String signUrlTemp) async {
    await _db
        .collection("case_survey")
        .doc(caseId)
        .update({'signatureUrl': signUrlTemp}).whenComplete(() {
      setLoading(false);
      signUrl.value = signUrlTemp;
    });
  }

  void setpdfurl(String caseId, String pdfURL) async {
    await _db
        .collection("case_survey")
        .doc(caseId)
        .update({'pdfUrl': pdfURL, 'isPdfExported': true}).whenComplete(() {
      pdfUrl.value = pdfURL;
    });
  }

  Future<String?> uploadPdf(File pdfFile, String filename) async {
    var ref = FirebaseStorage.instance.ref().child('casepdf').child(filename);
    await ref.putFile(pdfFile);
    return await ref.getDownloadURL();
  }
}
