import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/screens/screen_tabs/rankings/animes_ranking.dart';
import 'package:mymedialist/screens/screen_tabs/rankings/games_ranking.dart';
import 'package:mymedialist/screens/screen_tabs/rankings/mangas_ranking.dart';
import 'package:mymedialist/screens/screen_tabs/rankings/movies_ranking.dart';
import 'package:mymedialist/screens/screen_tabs/rankings/series_ranking.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/main_head.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});
  static const String routeName = "search-screen";

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

@override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener((){
      setState(() => _selectedIndex = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: MainHead(withSearch: false,)
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: AppTheme.primary,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: 'Anime',
                    icon: SvgPicture.asset(
                      "assets/images/anime.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode((_selectedIndex == 0) ? AppTheme.primary : Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  Tab(
                    text: 'Pelis',
                    icon: SvgPicture.asset(
                      "assets/images/movie.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode((_selectedIndex == 1) ? AppTheme.primary : Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  Tab(
                    text: 'Games',
                    icon: SvgPicture.asset(
                      "assets/images/game.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode((_selectedIndex == 2) ? AppTheme.primary : Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  Tab(
                    text: 'Manga',
                    icon: SvgPicture.asset(
                      "assets/images/manga.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode((_selectedIndex == 3) ? AppTheme.primary : Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  Tab(
                    text: 'Series',
                    icon: SvgPicture.asset(
                      "assets/images/serie.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode((_selectedIndex == 4) ? AppTheme.primary : Colors.black, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AnimesRanking(),
                  MoviesRanking(),
                  GamesRanking(),
                  MangasRanking(),
                  SeriesRanking()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
