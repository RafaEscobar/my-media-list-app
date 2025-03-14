import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class MoviesRanking extends StatefulWidget {
  const MoviesRanking({super.key});

  @override
  State<MoviesRanking> createState() => _MoviesRankingState();
}

class _MoviesRankingState extends State<MoviesRanking> {
  late RankingProvider _rankingProvider;
  late List<Entity> shortList;
  late List<Entity> list;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    shortList = _rankingProvider.movieList.take(3).toList();
    list = _rankingProvider.movieList.length>3 ? _rankingProvider.movieList.sublist(3) : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList,);
  }
}