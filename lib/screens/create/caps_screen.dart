import 'package:flutter/material.dart';

class CapsScreen extends StatelessWidget {
  const CapsScreen({super.key});
  static const String routeName = 'num-caps';

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text("Ńumero de caps"),
    );
  }
}