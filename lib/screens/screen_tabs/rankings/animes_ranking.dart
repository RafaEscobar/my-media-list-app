import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/general/alert.dart';
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
      await rankingProvider.getNewRanking(categoryId:  CategoryEnum.animes.identifier);
      _generateLists();
      setState(() => isUpdating = false);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _generateLists() {
    shortList = _rankingProvider.animeList.take(3).toList();
    list = _rankingProvider.animeList.length>3 ? _rankingProvider.animeList.sublist(_rankingProvider.animeList.length-3) : [];
  }

  @override
  Widget build(BuildContext context) {
    return isUpdating ?
      SizedBox(
        child: Center(
          child: Lottie.asset(
            width: 200,
            "assets/animations/loader_a.json",
            renderCache: RenderCache.drawingCommands,
            fit: BoxFit.fitHeight
          ),
        ),
      ) :
      RankingWidget(list: list, shortList: shortList, refresh: _updateList,);
  }
}