import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class GamesRanking extends StatefulWidget {
  const GamesRanking({super.key});

  @override
  State<GamesRanking> createState() => _GamesRankingState();
}

class _GamesRankingState extends State<GamesRanking> {
  late RankingProvider _rankingProvider;
  late List<Entity> shortList;
  late List<Entity> list;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    shortList = _rankingProvider.gameList.take(3).toList();
    list = _rankingProvider.gameList.length>3 ? _rankingProvider.gameList.sublist(_rankingProvider.gameList.length-3) : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList,);
  }
}