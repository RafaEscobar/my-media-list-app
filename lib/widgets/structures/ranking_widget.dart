import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/draws/light.dart';
import 'package:mymedialist/widgets/draws/podium.dart';
import 'package:mymedialist/widgets/general/ranking_card.dart';
import 'package:provider/provider.dart';

class RankingWidget extends StatelessWidget{
  const RankingWidget({
    super.key,
    required this.currentList
  });
  final List<Entity> currentList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        children: [
          Positioned(
            child: Row(
              children: [
                
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
                  return ListView.builder(
                    itemCount: currentList.length,
                    itemBuilder: (context, index) => RankingCard(entity: currentList[index])
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