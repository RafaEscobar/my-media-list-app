import 'package:flutter/material.dart';
import 'package:mymedialist/provider/ranking_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/draws/light.dart';
import 'package:mymedialist/widgets/draws/podium.dart';
import 'package:provider/provider.dart';
//import 'package:mymedialist/widgets/general/empty_state.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});
  static const String routeName = "search-screen";

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  late RankingProvider _rankingProvider;

  @override
  void initState() {
    super.initState();
    _rankingProvider = context.read<RankingProvider>();
    _rankingProvider.getRankings();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
  }
}
