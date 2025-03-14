import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class SeriesRanking extends StatefulWidget {
  const SeriesRanking({super.key});

  @override
  State<SeriesRanking> createState() => _SeriesRankingState();
}

class _SeriesRankingState extends State<SeriesRanking> {
  late RankingProvider _rankingProvider;
  late List<Entity> shortList;
  late List<Entity> list;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    shortList = _rankingProvider.movieList.take(3).toList();
    list = _rankingProvider.movieList.length>3 ? _rankingProvider.movieList.sublist(_rankingProvider.movieList.length-3) : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList,);
  }
}