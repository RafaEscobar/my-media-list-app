import 'package:flutter/material.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({
    super.key,
    required this.onNextStep,
    required this.onPreviousStep
  });
  final Function() onNextStep;
  final Function() onPreviousStep;


  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  late ChapterProvider chapterProvider;
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    chapterProvider = context.read<ChapterProvider>();
    _currentValue = chapterProvider.score != 0 ? chapterProvider.score : 5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.only(right: 2, left: 2, top: 4, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FormTitle(title: '¿Qué calificación obtuvo?', maxLines: 2, textSize: 20,),
          Text(
            _currentValue.toStringAsFixed(1),
            style: const TextStyle(color: AppTheme.primary, fontSize: 40, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
            ),
            child: Slider(
              activeColor: AppTheme.primary,
              overlayColor: WidgetStatePropertyAll(Colors.blue.shade100),
              inactiveColor: Colors.black54,
              value: _currentValue,
              min: 1,
              max: 10,
              divisions: 90,
              label: _currentValue.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
          ),
          BottomButtons(
            textSize: 18,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(0),
            textBtnLeft: "Regresar",
            actionBtnL: widget.onPreviousStep,
            textBtnRight: "Continuar",
            actionBtnR: widget.onNextStep,
          )
        ],
      )
    );
  }
}