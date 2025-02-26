import 'package:flutter/material.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          Text("Step 2"),
          Placeholder()
        ],
      )
    );
  }
}