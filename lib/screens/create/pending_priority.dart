import 'package:flutter/material.dart';

class PendingPriority extends StatelessWidget {
  static const String routeName = 'pending-priority';
  const PendingPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pending priorities')),
    );
  }
}