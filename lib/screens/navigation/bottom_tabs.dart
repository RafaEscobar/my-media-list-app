import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:mymedialist/theme/app_theme.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key, required this.tabBarController});
  final MotionTabBarController tabBarController;

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MotionTabBar(
        controller: widget.tabBarController,
        initialSelectedTab: "Inicio",
        useSafeArea: true,
        labels: const ["Inicio", "Puntajes", "Añadir", "Pendientes", "Perfil"],
        icons: const [Icons.home_filled, Icons.grade_outlined, Icons.add_circle_outline_sharp, Icons.pending_actions_sharp, Icons.person_pin],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: AppTheme.primary,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            widget.tabBarController.index = value;
          });
        },
      ),
    );
  }
}