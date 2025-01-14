import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/screens/auth/splash_screen.dart';
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