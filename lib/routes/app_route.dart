import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/screens/auth/splash_screen.dart';
import 'package:mymedialist/screens/create/add_image_screen.dart';
import 'package:mymedialist/screens/create/num_caps.dart';
import 'package:mymedialist/screens/create/comment_screen.dart';
import 'package:mymedialist/screens/create/priority_screen.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/screens/create/season_screen.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/screens/create/title_screen.dart';
import 'package:mymedialist/screens/create/type_screen.dart';
import 'package:mymedialist/screens/main/details_screens.dart';
import 'package:mymedialist/screens/main/home_screen.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:provider/provider.dart';

class AppRoute {
  static RouterConfig<Object>? getGoRoutes(GlobalKey<NavigatorState> navigatorKey){
    List<RouteBase> routes = [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: MainNavigation.routeName,
            name: MainNavigation.routeName,
            builder: (BuildContext context, GoRouterState state) => const MainNavigation(),
            routes: [
              GoRoute(
                path: TypeScreen.routeName,
                name: TypeScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => const TypeScreen(),
              ),
              GoRoute(
                path: TitleScreen.routeName,
                name: TitleScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => const TitleScreen(),
              ),
              GoRoute(
                path: StatusScreen.routeName,
                name: StatusScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => StatusScreen(),
              ),
              GoRoute(
                path: ScoreScreen.routeName,
                name: ScoreScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => const ScoreScreen(),
              ),
              GoRoute(
                path: CommentScreen.routeName,
                name: CommentScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => const CommentScreen(),
              ),
              GoRoute(
                path: PriorityScreen.routeName,
                name: PriorityScreen.routeName,
                builder: ( BuildContext context, GoRouterState state ) => PriorityScreen()
              ),
              GoRoute(
                path: NumCaps.routeName,
                name: NumCaps.routeName,
                builder: ( BuildContext context, GoRouterState state) => const NumCaps(),
              ),
              GoRoute(
                path: SeasonScreen.routeName,
                name: SeasonScreen.routeName,
                builder: ( BuildContext context, GoRouterState state) => const SeasonScreen(),
              ),
              GoRoute(
                path: DetailsScreens.routeName,
                name: DetailsScreens.routeName,
                builder: ( BuildContext context, GoRouterState state) => const DetailsScreens(),
              ),
              GoRoute(
                path: AddImageScreen.routeName,
                name: AddImageScreen.routeName,
                builder: (BuildContext context, GoRouterState state) => const AddImageScreen(),
              )
            ]
          ),
          GoRoute(
            path: HomeScreen.routeName,
            name: HomeScreen.routeName,
            builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
          ),
          GoRoute(
            path: AuthScreen.routeName,
            name: AuthScreen.routeName,
            builder: (BuildContext context, GoRouterState state) => const AuthScreen(),
          )
        ]
      )
    ];
    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        AppProvider appProvider = context.read<AppProvider>();
        if (appProvider.showedSplash && state.matchedLocation == '/') {
          return (Preferences.rememberme) ? "/${MainNavigation.routeName}" : "/${AuthScreen.routeName}";
        }
        return null;
      },
    );
  }
}