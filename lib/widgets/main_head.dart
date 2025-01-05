import 'package:flutter/material.dart';

class MainHead extends StatelessWidget {
  const MainHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo.png", height: 60, width: 60),
          const Icon(Icons.search_sharp, size: 34,)
        ],
      ),
    );
  }
}