import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MediaTypeCard extends StatelessWidget {
  const MediaTypeCard({
    super.key,
    required this.svgPath,
    required this.name,
  });
  final String svgPath;
  final String name;
  void nextStep(){
    print('se');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: nextStep,
          splashColor: Colors.blue.shade50,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  child: SvgPicture.asset(
                    svgPath,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(Colors.blueGrey.shade600, BlendMode.srcIn),
                  ),
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade600),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}