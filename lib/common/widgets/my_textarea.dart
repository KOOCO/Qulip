import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';

class MyTextArea extends StatelessWidget {
  const MyTextArea({
    Key? key,
    this.controller,
    this.enabled = true,
    this.maxLength = 700,
    this.keyboard = TextInputType.text,
    this.accentcolor = yasRed,
    this.maxLines = 5,
    this.onChanged,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType keyboard;
  final Color accentcolor;
  final String labelText;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboard,
      maxLength: maxLength,
      cursorColor: accentcolor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentcolor),
        ),
        floatingLabelStyle: TextStyle(color: accentcolor),
        isDense: true,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
