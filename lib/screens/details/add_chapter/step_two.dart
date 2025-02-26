import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          const Text("Step 2"),
          const SizedBox(height: 100,),
          BottomButtons(
            textBtnLeft: "Cerrar",
            actionBtnL: () => (),
            textBtnRight: "Continuar",
            actionBtnR: () => (),
          )
        ],
      )
    );
  }
}