import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
    this.style,
    this.textAlign,
    this.textSize = 26,
    required this.title,
  });
  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? TextStyle(color: Colors.blueGrey.shade600, fontSize: textSize, fontWeight: FontWeight.w700),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}