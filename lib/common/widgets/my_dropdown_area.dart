import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';

class MyDropDownArea extends StatelessWidget {
  const MyDropDownArea({
    Key? key,
    required this.items,
    this.value,
    this.onchange,
    this.selectedItemBuilder,
    this.isExpanded,
    this.iconColor,
    this.hint,
  }) : super(key: key);

  // final String model;
  // final String Model;
  final List<DropdownMenuItem<String>> items;
  final dynamic value;
  final Function(String?)? onchange;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final bool? isExpanded;
  final Color? iconColor;
  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        menuMaxHeight: 200,
        hint: hint,
        iconEnabledColor: iconColor ?? Colors.white,
        iconDisabledColor: Colors.white,
        isExpanded: isExpanded ?? true,
        focusColor: yasRed,
        underline: const Divider(
          height: 0,
          thickness: 1,
          color: Colors.grey,
        ),
        value: value,
        onChanged: onchange,
        items: items,
        selectedItemBuilder: selectedItemBuilder,
        
      ),
    );
  }
}
