import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget{
  const EmptyState({
    required this.title,
    required this.lottieName,
    this.lottieWidth = 200,
    this.textStyle = const TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
    super.key,
  });
  final String title;
  final String lottieName;
  final double lottieWidth;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: textStyle, textAlign: TextAlign.center,),
            Lottie.asset(
              width: lottieWidth,
              "assets/animations/$lottieName.json",
              renderCache: RenderCache.drawingCommands,
              fit: BoxFit.fitHeight
            )
          ],
        )
    );
  }
}