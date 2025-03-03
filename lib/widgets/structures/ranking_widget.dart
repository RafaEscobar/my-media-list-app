import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/draws/light.dart';
import 'package:mymedialist/widgets/draws/podium.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';
import 'package:mymedialist/widgets/general/image_card.dart';
import 'package:mymedialist/widgets/general/ranking_card.dart';
import 'package:mymedialist/widgets/ranking/ranking_positions.dart';
import 'package:provider/provider.dart';

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
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 60,
            child: Row(
              spacing: 50,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(shortList.length>=2) Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Transform.rotate(
                    angle: -0.24,
                    child: ImageCard(imagePath: shortList[1].image, title: shortList[1].title)
                  )
                ),
                if(shortList.isNotEmpty) Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: ImageCard(imagePath: shortList[0].image, title: shortList[0].title)
                ),
                if(shortList.length>=3) Container(
                  margin: EdgeInsets.only(top: 38),
                  child: Transform.rotate(
                    angle: 0.24,
                    child: ImageCard(imagePath: shortList[2].image, title: shortList[2].title)
                  )
                ),
              ],
            )
          ),
          Positioned(
            top: 46,
            right: 92,
            left: 92,
            child: CustomPaint(
              size: Size(130, size.height * .4),
              painter: Light()
            ),
          ),
          const Positioned(
            right: 0,
            left: 0,
            top: 180,
            child: Podium()
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 200,
            child: RankingPositions()
          ),
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: size.height * .5,
              child: Consumer<RankingProvider>(
                builder: (context, value, child) {
                  if (list.isEmpty) {
                    return const EmptyState(
                    title: 'Aún no hay suficientes animes.',
                    textStyle: TextStyle(color: Colors.white, fontSize: 22),
                    lottieName: 'empty_state'
                  );
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => RankingCard(
                      entity: list[index],
                      position: (index+4),
                    ),
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }
}