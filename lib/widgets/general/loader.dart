import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/widgets/general/alert.dart';

class Loader {
  static void show(){
    showDialog(
      context: navigatorKey.currentState!.context,
      barrierColor:Colors.white,
      builder: (context) {
        return SizedBox(
          child: Center(
            child: Lottie.asset(
              width: 200,
              "assets/animations/loader_a.json",
              renderCache: RenderCache.drawingCommands,
              fit: BoxFit.fitHeight
            ),
          ),
        );
      },
    );
  }

  static void hide() => Navigator.pop(navigatorKey.currentState!.context);

  static Future<void> runLoad({required Future<void> Function() asyncFunction, int secondsDelayed = 1}) async {
    try {
      show();
      await asyncFunction();
      await Future.delayed(Duration(seconds: secondsDelayed));
    } catch (e) {
      Alert.show(text: e.toString());
    } finally {
      hide();
    }
  }
}