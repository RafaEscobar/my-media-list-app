import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/utils/call.dart';
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
      _setInitialConfig();
      bool rememberme = Preferences.rememberme;
      (rememberme && appProvider.userInfo.token.isNotEmpty) ? _onLoginSucces() : _onLogginFailure();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _setInitialConfig(){
    appProvider.showedSplash = true;
    appProvider.userInfo = Preferences.userInfo;
  }

  Future<void> _onLoginSucces() async {
    await Call.firstCalls();
    _exitController.forward().then((value) => context.goNamed(MainNavigation.routeName)) ;
  }

  void _onLogginFailure() => _exitController.forward().then((value) => context.goNamed(AuthScreen.routeName));

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
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SizedBox(
        child: Center(
          child: SvgPicture.asset(
            "assets/images/logob.svg",
            height: 140,
            width: 140,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      )
    );
  }
}