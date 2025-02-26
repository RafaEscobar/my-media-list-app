import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';

class StepOne extends StatelessWidget{
  const StepOne({
    super.key,
    required this.nextStep
  });
  final Function() nextStep;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          const Text("Step 1"),
          const SizedBox(height: 100,),
          BottomButtons(
            textBtnLeft: "Cerrar",
            actionBtnL: () => Navigator.of(context).pop(),
            textBtnRight: "Continuar",
            actionBtnR: nextStep,
          )
        ],
      )
    );
  }
}