import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/screens/lists/animes_screen.dart';
import 'package:mymedialist/screens/lists/mangas_screen.dart';
import 'package:mymedialist/screens/lists/movies_screen.dart';
import 'package:mymedialist/screens/lists/series_screen.dart';
import 'package:mymedialist/screens/lists/videogames_screens.dart';
import 'package:mymedialist/widgets/main_head.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MainHead()
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              indicatorColor: Colors.black,
              onTap: (value) {
                setState(() => _selectedIndex = value);
              },
              tabs: <Widget>[
                Tab(
                  text: 'Anime',
                  icon: SvgPicture.asset(
                    "assets/images/anime.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode((_selectedIndex == 0) ? Colors.blue : Colors.black, BlendMode.srcIn),
                  ),
                ),
                Tab(
                  text: 'Pelis',
                  icon: SvgPicture.asset(
                    "assets/images/movie.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode((_selectedIndex == 1) ? Colors.blue : Colors.black, BlendMode.srcIn),
                  ),
                ),
                Tab(
                  text: 'Games',
                  icon: SvgPicture.asset(
                    "assets/images/game.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode((_selectedIndex == 2) ? Colors.blue : Colors.black, BlendMode.srcIn),
                  ),
                ),
                Tab(
                  text: 'Manga',
                  icon: SvgPicture.asset(
                    "assets/images/manga.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode((_selectedIndex == 3) ? Colors.blue : Colors.black, BlendMode.srcIn),
                  ),
                ),
                Tab(
                  text: 'Series',
                  icon: SvgPicture.asset(
                    "assets/images/serie.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode((_selectedIndex == 4) ? Colors.blue : Colors.black, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          // TabBarView
          const Expanded(
            child: TabBarView(
              children: [
                AnimesScreen(),
                MoviesScreen(),
                VideogamesScreens(),
                MangasScreen(),
                SeriesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
