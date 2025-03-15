import 'package:flutter/material.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/general/alert.dart';
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
  bool isUpdating = false;

  @override
  void initState() {
    _rankingProvider = context.read<RankingProvider>();
    _generateLists();
    super.initState();
  }

  Future<void> _updateList() async {
    RankingProvider rankingProvider = context.read<RankingProvider>();
    try {
      setState(() => isUpdating = true);
      rankingProvider.getNewRanking(categoryId:  CategoryEnum.series.index);
      _generateLists();
      setState(() => isUpdating = false);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _generateLists() {
    shortList = _rankingProvider.serieList.take(3).toList();
    list = _rankingProvider.serieList.length>3 ? _rankingProvider.serieList.sublist(_rankingProvider.serieList.length-3) : [];
  }

  @override
  Widget build(BuildContext context) {
    return RankingWidget(list: list, shortList: shortList, refresh: _updateList,);
  }
}