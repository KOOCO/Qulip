import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.keyboard,
    this.borderRadius,
    this.contentPadding,
    this.maxLength,
    this.labelText,
    required this.hintText,
    this.placeholder,
    this.accentColor = yasRed,
    this.fillColor = yasRed,
    this.obscureText = false,
    this.enabled = true,
    this.isDateField = false,
    this.isDense = true,
    this.suffixIcon,
    this.prefixIcon,
    this.hasFloatingLabel = true,
    this.autofocus = false,
    this.hasBorder = true,
    this.fullBorder = false,
    this.readOnly = false,
    this.validator,
    this.expand = false,
    this.minLine = 1,
    this.maxLine = 1,
    this.textAlign = TextAlignVertical.center,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.fontSize = 12,
    this.onChanged,
    this.onSubmit,
    this.colorFilled = false,
    this.hintcolor = stdgrey,
    this.labelcolor = stdgrey,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final String? placeholder;
  final TextInputType? keyboard;
  final Color? accentColor;
  final Color? fillColor;
  final Color? hintcolor;
  final Color? labelcolor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool hasFloatingLabel;
  final bool obscureText;
  final TextAlignVertical textAlign;
  final bool enabled;
  final bool isDateField;
  final bool expand;
  final bool isDense;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  final BorderRadius? borderRadius;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final bool hasBorder;
  final bool fullBorder;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final double? fontSize;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final bool? colorFilled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      expands: expand,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      minLines: minLine,
      maxLines: maxLine,
      readOnly: readOnly,
      textAlignVertical: textAlign,
      autovalidateMode: autovalidateMode,
      cursorColor:
          accentColor ?? Theme.of(context).textSelectionTheme.cursorColor,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboard,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      autofocus: autofocus,
      style: const TextStyle(fontFamily: FontFamilyConstant.sinkinSans),
      decoration: InputDecoration(
        // errorStyle: const TextStyle(
        //   fontSize: 0,
        // ),
        counterText: '',
        isDense: isDense,
        fillColor: fillColor,
        filled: colorFilled,
        labelText: labelText,
        hintStyle: TextStyle(
          color: hintcolor,
          fontSize: fontSize,
          fontFamily: FontFamilyConstant.sinkinSansMedium,
        ),
        labelStyle: TextStyle(
          color: labelcolor,
          fontSize: fontSize,
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        contentPadding: contentPadding,
        floatingLabelBehavior: hasFloatingLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.always,
        iconColor: accentColor ?? Theme.of(context).colorScheme.onPrimary,
        floatingLabelStyle: TextStyle(
          color: accentColor,
        ),
        prefixIconColor: accentColor ?? Theme.of(context).colorScheme.onPrimary,
        focusColor: accentColor ?? Theme.of(context).colorScheme.onPrimary,
        focusedBorder: hasBorder
            ? fullBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: fillColor ?? yasRed,
                    ),
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(5.0)),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: accentColor ??
                          Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
            : null,
        border: hasBorder
            ? fullBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: fillColor ?? yasRed,
                    ),
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(5.0)),
                  )
                : null
            : const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),

        disabledBorder: isDateField
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: fillColor ?? yasRed,
                ),
                borderRadius: borderRadius ??
                    const BorderRadius.all(Radius.circular(5.0)),
              )
            : OutlineInputBorder(
                borderSide: const BorderSide(
                  color: stdgrey,
                ),
                borderRadius: borderRadius ??
                    const BorderRadius.all(Radius.circular(5.0)),
              ),
        enabledBorder: hasBorder
            ? fullBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: fillColor ?? yasRed,
                    ),
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(5.0)),
                  )
                : null
            : const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
