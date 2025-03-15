import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/widgets/general/alert.dart';
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
      await rankingProvider.getNewRanking(categoryId:  CategoryEnum.videogames.identifier);
      _generateLists();
      setState(() => isUpdating = false);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _generateLists() {
    shortList = _rankingProvider.gameList.take(3).toList();
    list = _rankingProvider.gameList.length>3 ? _rankingProvider.gameList.sublist(_rankingProvider.gameList.length-3) : [];
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