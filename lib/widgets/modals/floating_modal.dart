import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class FloatingModal {
  static void open({required String title, required Widget body, required Widget footer}) {
    showDialog<void>(
      barrierDismissible: false,
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormTitle(title: title, textSize: 20,),
                body,
                footer
              ],
            ),
          ),
        );
      },
    );
  }
}