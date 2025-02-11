
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/provider/category_provider.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:mymedialist/provider/post_view_priority_provider.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:mymedialist/routes/app_route.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await dotenv.load(fileName: '.env');
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(),),
        ChangeNotifierProvider(create: (_) => MediaProvider(),),
        ChangeNotifierProvider(create: (_) => CategoryProvider(),),
        ChangeNotifierProvider(create: (_) => StatusProvider(),),
        ChangeNotifierProvider(create: (_) => PendingPriorityProvider(),),
        ChangeNotifierProvider(create: (_) => PostViewPriorityProvider(),),
        ChangeNotifierProvider(create: (_) => EntertainmentEntityProvider(),),
        ChangeNotifierProvider(create: (_) => SagaProvider())
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