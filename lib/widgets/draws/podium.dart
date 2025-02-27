import 'package:flutter/material.dart';
import 'package:mymedialist/theme/app_theme.dart';

class Podium extends StatelessWidget{
  const Podium({super.key});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            transform: Matrix4.identity()..setEntry(3, 2, 0.010)..rotateY(0.3),
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 164,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade300, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, Colors.white],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Transform(
            transform: Matrix4.identity()..setEntry(3, 2, 0.010)..rotateY(-0.3),
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 164,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.white],
                  begin: Alignment.centerRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}