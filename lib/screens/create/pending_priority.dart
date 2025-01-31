import 'package:flutter/material.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:provider/provider.dart';

class PendingPriority extends StatelessWidget {
  static const String routeName = 'pending-priority';
  const PendingPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Pending priorities:  ${context.read<PendingPriorityProvider>().pendingPriorityList.length}')),
    );
  }
}