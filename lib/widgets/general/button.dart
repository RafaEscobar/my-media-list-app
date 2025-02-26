import 'package:flutter/material.dart';
import 'package:mymedialist/theme/app_theme.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.backgroundSplash = AppTheme.primary,
    this.background = Colors.black,
    this.textColor = Colors.white,
    this.textSize = 22,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.borderRadius = 10,
    this.buttonWidth = 100,
    this.buttonHeight = 46,
    this.action,
    this.textWeight,
    this.text,
    this.icon
  });

  final Function()? action;
  final String? text;
  final Color background;
  final Color backgroundSplash;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double buttonWidth;
  final double buttonHeight;
  final FontWeight? textWeight;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      color: Colors.transparent,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: action,
          splashColor: backgroundSplash,
          child: Container(
            padding: padding,
            child: text != null ?
              Center(
                child: Text(
                  text!,
                  style: TextStyle(color: textColor, fontSize: textSize, fontWeight: textWeight),
                ),
              ) :
              icon
          ),
        ),
      ),
    );
  }
}
