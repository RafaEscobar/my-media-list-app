import 'package:flutter/material.dart';

class PendingsScreen extends StatelessWidget {
  const PendingsScreen({super.key});
  static const String routeName = "pending-screen";

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("Pendientes"),
      ),
    );
  }
}