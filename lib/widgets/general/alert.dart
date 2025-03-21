import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';

class Alert {
  static void show({
    required String text,
    Color background = Colors.white,
    Color textColor = Colors.black,
    double textSize = 14,
    Duration duration = const Duration(milliseconds: 2300),
    double? contentWidth,
    bool centeredText = false,
  }){
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize),
          textAlign: centeredText ? TextAlign.center : null,
        ),
        backgroundColor: background,
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        duration: duration,
        width: contentWidth ?? 200,
      )
    );
  }
}