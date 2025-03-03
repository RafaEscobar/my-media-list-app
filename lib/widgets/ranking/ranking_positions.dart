import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class RankingPositions extends StatelessWidget {
  const RankingPositions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child:  FormTitle(title: "°2", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: FormTitle(title: "°1", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: FormTitle(title: "°3", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
        ),
      ],
    );
  }
}