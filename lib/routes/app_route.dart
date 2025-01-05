import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/screens/auth/splash_screen.dart';
import 'package:mymedialist/screens/main/home_screen.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';

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
          ),
          GoRoute(
            path: HomeScreen.routeName,
            name: HomeScreen.routeName,
            builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
          )
        ]
      )
    ];
    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
    );
  }
}