import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});
  static const String routeName = "create-screen";

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("Crear"),
      ),
    );
  }
}