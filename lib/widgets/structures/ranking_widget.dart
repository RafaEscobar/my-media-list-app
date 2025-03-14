import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/widgets/draws/light.dart';
import 'package:mymedialist/widgets/draws/podium.dart';
import 'package:mymedialist/widgets/ranking/ranking_last_places.dart';
import 'package:mymedialist/widgets/ranking/ranking_positions.dart';
import 'package:mymedialist/widgets/ranking/ranking_top_places.dart';

class RankingWidget extends StatelessWidget{
  const RankingWidget({
    super.key,
    required this.shortList,
    required this.list
  });
  final List<Entity> shortList;
  final List<Entity> list;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * .9,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Positioned(right: 0, left: 0, top: 28, child: RankingTopPlaces(currentList: shortList)),
            Positioned(
              right: 92,
              left: 92,
              child: CustomPaint(
                size: Size(130, size.height * .4),
                painter: Light()
              ),
            ),
            const Positioned(right: 0, left: 0, top: 164, child: Podium()),
            Positioned( right: 0, left: 0, top: 176, child: RankingPositions()),
            Positioned(top: 330, left: 0, right: 0, child: RankingLastPlaces(currentList: list, height: size.height))
          ],
        ),
      ),
    );
  }
}