import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
    this.style,
    this.textAlign,
    this.textSize = 26,
    this.maxLines = 1,
    required this.title,
  });
  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double textSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? TextStyle(color: Colors.blueGrey.shade600, fontSize: textSize, fontWeight: FontWeight.w700),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
    );
  }
}