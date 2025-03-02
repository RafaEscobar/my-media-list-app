import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class AnimesRanking extends StatelessWidget {
  const AnimesRanking({super.key});
  late List<Entity> shortList;
  late List<Entity> list;

  init

  @override
  Widget build(BuildContext context) {
    return RankingWidget(currentList: context.read<RankingProvider>().animeList);
  }
}