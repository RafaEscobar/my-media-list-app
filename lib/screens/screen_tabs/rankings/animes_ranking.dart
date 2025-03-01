import 'package:flutter/material.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class AnimesRanking extends StatelessWidget {
  const AnimesRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return RankingWidget(currentList: context.read<RankingProvider>().animeList);
  }
}