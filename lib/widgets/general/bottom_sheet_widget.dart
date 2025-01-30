import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';

class BottomSheetWidget {
  static void open({
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    AlignmentGeometry alignment = Alignment.centerLeft,
    double height = 350,
    bool dismissible = false,
    required String title,
    required Widget body,
    Widget? footer,
  }) {
    showModalBottomSheet(
      isDismissible: dismissible,
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            padding: padding,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.cancel_outlined, size: 32, color: Colors.blueGrey.shade600,)
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 24, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: alignment,
                      child: body
                    )
                  ],
                ),
                footer ?? Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
