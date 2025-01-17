import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _exitController;
  AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  Future<void> initLoad() async {
    try {
      appProvider.showedSplash = true;
      bool rememberme = Preferences.rememberme;
      appProvider.userInfo = Preferences.userInfo;
      if (rememberme && appProvider.userInfo.token.isNotEmpty) {
        await appProvider.initApp();
        _exitController.forward().then((value) => context.goNamed(MainNavigation.routeName)) ;
      } else {
        _exitController.forward().then((value) => context.goNamed(AuthScreen.routeName));
      }

    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _exitController = AnimationController(vsync: this,duration: const Duration(milliseconds: 600));
    WidgetsBinding.instance.addPostFrameCallback((_){
      initLoad();
    });
  }

  @override
  void dispose() {
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
    );
  }
}