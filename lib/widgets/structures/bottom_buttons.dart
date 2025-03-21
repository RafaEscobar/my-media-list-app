import 'package:flutter/material.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/button.dart';

class BottomButtons extends StatelessWidget{
  const BottomButtons({
    super.key,
    this.margin = const EdgeInsets.only(bottom: 40),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.backgroundBtnL = Colors.black87,
    this.textColorBtnL = Colors.white,
    this.splashBtnL = Colors.white,
    this.backgroundBtnR = AppTheme.primary,
    this.textColorBtnR = Colors.white,
    this.splashBtnR = Colors.white,
    this.onlyOneBtn = false,
    this.textBtnRight = "Continuar",
    this.textSize = 22,
    this.actionBtnR,
    required this.textBtnLeft,
    required this.actionBtnL,
  });

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final String textBtnLeft;
  final String textBtnRight;
  final Color backgroundBtnL;
  final Color textColorBtnL;
  final Color splashBtnL;
  final Color backgroundBtnR;
  final Color textColorBtnR;
  final Color splashBtnR;
  final Function() actionBtnL;
  final Function()? actionBtnR;
  final bool onlyOneBtn;
  final double textSize;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: !onlyOneBtn ? 20.0 : 0,
        children: [
          Expanded(
            child: Button(
              textSize: textSize,
              text: textBtnLeft,
              textWeight: FontWeight.w500,
              backgroundSplash: splashBtnL,
              textColor: textColorBtnL,
              background: backgroundBtnL,
              borderRadius: 20,
              padding: padding,
              action: actionBtnL,
            ),
          ),
          Visibility(
            visible: !onlyOneBtn,
            child: Expanded(
              child: Button(
                textSize: textSize,
                text: textBtnRight,
                textWeight: FontWeight.w500,
                backgroundSplash: splashBtnR,
                textColor: textColorBtnR,
                background: backgroundBtnR,
                borderRadius: 20,
                padding: padding,
                action: actionBtnR,
              ),
            ),
          ),
        ],
      ),
    );
  }
}