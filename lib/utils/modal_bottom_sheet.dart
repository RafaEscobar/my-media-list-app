import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';

class ModalBottomSheet {
  static void showModal({required Widget body, double height = 300, required bool dismissible}){
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: dismissible,
      context: navigatorKey.currentState!.context,
      backgroundColor: Colors.transparent,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white,
          ),
          height: height,
          child: body,
        ),
      )
    );
  }
}