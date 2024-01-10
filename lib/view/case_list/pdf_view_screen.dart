import 'dart:async';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/case_list_controller.dart';

class PdfViewPage extends StatelessWidget {
  PdfViewPage({super.key});
  String url = '';
  final _isLoading = true.obs;
  late PDFDocument? doc;

  final controller = Get.find<CaseListController>();
  @override
  Widget build(BuildContext context) {
    url = Get.arguments;
    loadPDF().then((value) {
      _isLoading.value = false;
      doc = value;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          "",
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      body: Obx(
        () => Center(
          child: _isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: doc!,
                  enableSwipeNavigation: true,
                  showIndicator: true,
                  showNavigation: false,
                  showPicker: false,
                  lazyLoad: false,
                  scrollDirection: Axis.vertical),
        ),
      ),
    );
  }

  Future<PDFDocument?> loadPDF() async {
    doc = await PDFDocument.fromURL(url);
    return doc;
  }
}
