import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/screens/create/type_screen.dart';
import 'package:mymedialist/screens/main/grades_screen.dart';
import 'package:mymedialist/screens/main/home_screen.dart';
import 'package:mymedialist/screens/main/pendings_screen.dart';
import 'package:mymedialist/screens/main/profile_screen.dart';
import 'package:mymedialist/screens/navigation/bottom_tabs.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  static const String routeName = "main-screen";

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with TickerProviderStateMixin  {

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
      _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _motionTabBarController,
              children: const [
                HomeScreen(),
                GradesScreen(),
                //TypeScreen(),
                ScoreScreen(),
                PendingsScreen(),
                ProfileScreen()
              ],
            ),
            bottomNavigationBar: BottomTabs(tabBarController: _motionTabBarController!,),
          ),
        ),
      ),
    );
  }
}