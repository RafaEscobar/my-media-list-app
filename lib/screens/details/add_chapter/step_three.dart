import 'package:flutter/material.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          Text("Step 3"),
          Placeholder()
        ],
      )
    );
  }
}