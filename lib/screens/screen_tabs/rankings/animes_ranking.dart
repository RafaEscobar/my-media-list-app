import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class AnimesRanking extends StatefulWidget {
  const AnimesRanking({super.key});

  @override
  State<AnimesRanking> createState() => _AnimesRankingState();
}

class _AnimesRankingState extends State<AnimesRanking> {
  late RankingProvider _rankingProvider;
  late List<Entity> shortList;
  late List<Entity> list;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    shortList = _rankingProvider.animeList.take(3).toList();
    list = _rankingProvider.animeList.length>3 ? _rankingProvider.animeList.sublist(_rankingProvider.animeList.length-3) : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList,);
  }
}