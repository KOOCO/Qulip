import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_textfield.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown(
      {super.key,
      required this.item,
      required this.onChanged,
      required this.controller,
      required this.hintText});

  final List<String> item;
  final Function(String?)? onChanged;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      margin: const EdgeInsets.only(left: 45, right: 45, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          width: 1,
          color: yasRed,
        ),
      ),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: MyTextField(
            fullBorder: false,
            hasBorder: false,
            enabled: false,
            hasFloatingLabel: false,
            controller: controller,
            keyboard: TextInputType.text,
            hintText: hintText,
          ),
        ),
        Container(
          width: 200,
          margin: const EdgeInsets.only(right: 20),
          child: DropdownButton<String>(
            items: item.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        )
      ]),
    );
  }
}
