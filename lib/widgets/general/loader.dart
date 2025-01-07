import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/widgets/general/alert.dart';

class Loader {
  void show(){
    showDialog(
      context: navigatorKey.currentState!.context,
      barrierColor: Colors.white,
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

  void hide() => Navigator.pop(navigatorKey.currentState!.context);

  Future<void> runLoad(Future<void> Function() asyncFunction) async {
    try {
      show();
      await asyncFunction();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Alert.show(text: e.toString());
    } finally {
      hide();
    }
  }
}