
import 'package:flutter/material.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/provider/category_provider.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:mymedialist/routes/app_route.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider(),),
        ChangeNotifierProvider(create: (context) => MediaProvider(),),
        ChangeNotifierProvider(create: (context) => CategoryProvider(),),
        ChangeNotifierProvider(create: (context) => StatusProvider(),)
      ],
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.getGoRoutes(navigatorKey),
        );
      },
    );
  }
}