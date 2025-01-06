import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.action,
    required this.text,
    this.background = Colors.black,
    this.textColor = Colors.white,
    this.textSize = 22,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.borderRadius = 10,
  });
  final Function() action;
  final String text;
  final Color background;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)
        )
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: textSize),),
    );
  }
}