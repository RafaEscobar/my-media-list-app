import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';

class InputFooter extends StatelessWidget {
  const InputFooter({
    super.key,
    required this.action
  });
  final Function() action;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: BottomButtons(
        textSize: 18,
        textBtnLeft: 'Cerrar',
        actionBtnL: () => Navigator.of(context).pop(),
        textBtnRight: 'Aceptar',
        actionBtnR: action,
        margin: const EdgeInsets.only(bottom: 0),
      ),
    );
  }
}