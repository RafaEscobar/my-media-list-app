import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatefulWidget {
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
    this.isPassword = false,
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
  final bool isPassword;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void changeObscureText() => setState(() => obscureText = !obscureText);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      style: widget.textStyle,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      validator: widget.validator,
      decoration: InputDecoration(
        counterText: widget.showMaxLenght ? null : '',
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        enabledBorder: widget.enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
        focusedBorder: widget.focusedBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
        errorBorder: widget.errorBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(16),
        suffixIcon: widget.isPassword ? IconButton(
          onPressed: changeObscureText,
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off)
        ) : null
      ),
      name: '',
    );
  }
}
