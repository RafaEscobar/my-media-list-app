import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  const TimeLine({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.height = 6,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey
  });
  final int currentStep;
  final int totalSteps;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double activeWidth = (currentStep / totalSteps) * totalWidth;
        return Stack(
          children: [
            Container(
              width: totalWidth,
              height: height,
              color: inactiveColor,
            ),
            // Línea activa
            Container(
              width: activeWidth,
              height: height,
              color: activeColor,
            ),
          ],
        );
      },
    );
  }
}