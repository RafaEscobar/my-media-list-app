import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController _exitController;

  Future<void> initLoad() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _exitController.forward().then((value) => context.goNamed(MainNavigation.routeName));
  }

  @override
  void initState() {
    super.initState();
    _exitController = AnimationController(vsync: this,duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}