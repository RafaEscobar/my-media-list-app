import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

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
        labels: const ["Inicio", "Buscar", "Añadir", "Pendientes", "Perfil"],
        icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings, Icons.ac_unit_rounded],
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
        tabSelectedColor: Colors.blue[900],
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