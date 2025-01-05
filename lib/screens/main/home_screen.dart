import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/screens/lists/animes_screen.dart';
import 'package:mymedialist/screens/lists/mangas_screen.dart';
import 'package:mymedialist/screens/lists/movies_screen.dart';
import 'package:mymedialist/screens/lists/series_screen.dart';
import 'package:mymedialist/screens/lists/videogames_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DefaultTabController(
            initialIndex: 0,
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: 'Anime',
                      icon: SvgPicture.asset("assets/images/anime.svg", height: 20, width: 20,),
                    ),
                    Tab(
                      text: 'Pelis',
                      icon: SvgPicture.asset("assets/images/movie.svg", height: 20, width: 20),
                    ),
                    Tab(
                      text: 'Games',
                      icon: SvgPicture.asset("assets/images/game.svg", height: 20, width: 20),
                    ),
                    Tab(
                      text: 'Mangas',
                      icon: SvgPicture.asset("assets/images/manga.svg", height: 20, width: 20),
                    ),
                    Tab(
                      text: 'Series',
                      icon: SvgPicture.asset("assets/images/serie.svg", height: 20, width: 20),
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  AnimesScreen(),
                  MoviesScreen(),
                  VideogamesScreens(),
                  MangasScreen(),
                  SeriesScreen()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
