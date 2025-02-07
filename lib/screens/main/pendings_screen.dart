import 'package:flutter/material.dart';

class PendingsScreen extends StatefulWidget {
  const PendingsScreen({super.key});
  static const String routeName = "pending-screen";

  @override
  State<PendingsScreen> createState() => _PendingsScreenState();
}

class _PendingsScreenState extends State<PendingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text('data')
      ),
    );
  }
}