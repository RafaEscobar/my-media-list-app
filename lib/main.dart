
import 'package:flutter/material.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/routes/app_route.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main(){
  return runApp(const MyClass());
}

class MyClass extends StatelessWidget
{
  const MyClass({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider(),)
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