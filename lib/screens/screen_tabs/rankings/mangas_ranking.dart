import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/structures/ranking_widget.dart';
import 'package:provider/provider.dart';

class MangasRanking extends StatefulWidget {
  const MangasRanking({super.key});

  @override
  State<MangasRanking> createState() => _MangasRankingState();
}

class _MangasRankingState extends State<MangasRanking> {
  late RankingProvider _rankingProvider;
  late List<Entity> shortList;
  late List<Entity> list;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    shortList = _rankingProvider.mangaList.take(3).toList();
    list = _rankingProvider.mangaList.length>3 ? _rankingProvider.mangaList.sublist(_rankingProvider.mangaList.length-3) : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList,);
  }
}