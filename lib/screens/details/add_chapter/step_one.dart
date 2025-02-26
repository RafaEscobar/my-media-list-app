import 'package:flutter/material.dart';

class StepOne extends StatelessWidget{
  const StepOne({super.key});

  @override
  Widget build(BuildContext context){
    return const SizedBox(
      child: Column(
        children: [
          Text("Step 1"),
          Placeholder()
        ],
      )
    );
  }
}