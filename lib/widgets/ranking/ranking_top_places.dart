import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/widgets/general/image_card.dart';

class RankingTopPlaces extends StatelessWidget {
  const RankingTopPlaces({super.key, required this.currentList});
  final List<Entity> currentList;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 50,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(currentList.length>=2) Container(
          margin: EdgeInsets.only(top: 35),
          child: Transform.rotate(
            angle: -0.24,
            child: ImageCard(imagePath: currentList[1].image, title: currentList[1].title)
          )
        ),
        if(currentList.isNotEmpty) Container(
          margin: EdgeInsets.only(bottom: 32),
          child: ImageCard(imagePath: currentList[0].image, title: currentList[0].title)
        ),
        if(currentList.length>=3) Container(
          margin: EdgeInsets.only(top: 38),
          child: Transform.rotate(
            angle: 0.24,
            child: ImageCard(imagePath: currentList[2].image, title: currentList[2].title)
          )
        ),
      ],
    );
  }
}