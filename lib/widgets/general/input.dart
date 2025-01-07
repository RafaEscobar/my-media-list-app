import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.keyboardType,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.maxLength,
    this.contentPadding,
    this.onTap,
    this.showMaxLenght = false,
    this.validator,
    required this.focusNode,
    required this.obscureText,
    required this.controller,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTap;
  final bool showMaxLenght;
  final FormFieldValidator<String>? validator;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: textStyle,
      maxLength: maxLength,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        counterText: showMaxLenght ? null : '',
        hintText: hintText,
        hintStyle: hintStyle,
        enabledBorder: enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
        focusedBorder: focusedBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
        errorBorder: errorBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
      ), name: '',
    );
  }
}
