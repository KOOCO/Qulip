import 'package:flutter/material.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';

class SurveyForm2Screen extends StatefulWidget {
  const SurveyForm2Screen({super.key});

  @override
  State<SurveyForm2Screen> createState() => _SurveyForm2ScreenState();
}

class _SurveyForm2ScreenState extends State<SurveyForm2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const MyText(
            WordStrings.surveyFormCreatelLbl,
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        body:Text("Survey Form 2 - Canvas"));
  }
}