import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  Future<void> initLoad() async {
    context.read<AppProvider>().showedSplash = true;
    bool rememberme = Preferences.rememberme;
    String token = Preferences.token;
    if (rememberme && token.isNotEmpty) {
      _exitController.forward().then((value) => context.goNamed(MainNavigation.routeName));
    } else {
      _exitController.forward().then((value) => context.goNamed(AuthScreen.routeName));
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