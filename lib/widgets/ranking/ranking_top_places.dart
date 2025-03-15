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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 19),
          child: Transform.rotate(
            angle: -0.24,
            child: (currentList.length>=2) ? ImageCard(entity: currentList[1]) : ImageCard()
          )
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: (currentList.isNotEmpty) ? ImageCard(entity: currentList[0]) : ImageCard()
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Transform.rotate(
            angle: 0.24,
            child: (currentList.length>=3) ? ImageCard(entity: currentList[2]) : ImageCard(),
          )
        )
      ],
    );
  }
}