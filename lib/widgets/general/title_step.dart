import 'package:flutter/material.dart';

class TitleStep extends StatelessWidget {
  const TitleStep({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 28, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}