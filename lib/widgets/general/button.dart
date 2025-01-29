import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.backgroundSplash,
    this.background = Colors.black,
    this.textColor = Colors.white,
    this.textSize = 22,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.borderRadius = 10,
    this.buttonWidth = 100,
    this.action,
    this.textWeight,
  });

  final Function()? action;
  final String text;
  final Color background;
  final Color backgroundSplash;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double buttonWidth;
  final FontWeight? textWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      color: Colors.white,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: action,
          splashColor: backgroundSplash,
          child: Container(
            padding: padding,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: textSize, fontWeight: textWeight),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
