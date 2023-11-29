import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_text.dart';

class MyRadioButton extends StatelessWidget {
  const MyRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  final dynamic value;
  final dynamic groupValue;
  final dynamic onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: yasRed,
        ),
        MyText(label),
      ],
    );
  }
}
