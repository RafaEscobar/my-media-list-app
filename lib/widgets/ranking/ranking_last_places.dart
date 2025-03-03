import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';
import 'package:mymedialist/widgets/general/ranking_card.dart';
import 'package:provider/provider.dart';

class RankingLastPlaces extends StatelessWidget{
  const RankingLastPlaces({
    super.key,
    required this.currentList,
    required this.height
  });
  final List<Entity> currentList;
  final double height;

   @override
   Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: height * .5,
      child: Consumer<RankingProvider>(
        builder: (context, value, child) {
          if (currentList.isEmpty) {
            return const EmptyState(
              title: 'Aún no hay suficientes animes.',
              textStyle: TextStyle(color: Colors.white, fontSize: 22),
              lottieName: 'empty_state'
            );
          }
          return ListView.builder(
            itemCount: currentList.length,
            itemBuilder: (context, index) => RankingCard(
              entity: currentList[index],
              position: (index+4),
            )
          );
        },
      )
    );
   }
}