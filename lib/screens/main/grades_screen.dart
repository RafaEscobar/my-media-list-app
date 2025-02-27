import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/draws/light.dart';
import 'package:mymedialist/widgets/draws/podium.dart';
//import 'package:mymedialist/widgets/general/empty_state.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});
  static const String routeName = "search-screen";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
            top: 50,
            right: 92,
            left: 92,
            child: CustomPaint(
              size: Size(130, MediaQuery.of(context).size.height * .4),
              painter: Light()
            ),
          ),
          const Positioned(
            right: 0,
            left: 0,
            top: 220,
            child: Podium()
          )
        ],
      ),
    );
  }
}
