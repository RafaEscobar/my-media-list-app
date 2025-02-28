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
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        children: [
          Positioned(
            top: 46,
            right: 92,
            left: 92,
            child: CustomPaint(
              size: Size(130, size.height * .4),
              painter: Light()
            ),
          ),
          const Positioned(
            right: 0,
            left: 0,
            top: 180,
            child: Podium()
          ),
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 126, 180, 247),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: size.height * .5,
              child: Placeholder()
            ),
          )
        ],
      ),
    );
  }
}
