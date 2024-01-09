import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/establish_case_controller.dart';
// import 'package:printing/printing.dart';

class ViewCanvas extends StatelessWidget {
  ViewCanvas({super.key});

  final controller = Get.find<EstablishCaseController>();

  @override
  Widget build(BuildContext context) {
    final curl = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: stdwhite,
          foregroundColor: yasRed,
          centerTitle: true,
          title: MyText(
            "${controller.txtCaseName.text}_${WordStrings.surveyFormCreatelLbl}",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        body: Center(
          child: Image.network(
            width: double.infinity,
            fit: BoxFit.fill,
            curl.toString(),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: yasRed,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
