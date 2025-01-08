import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/screens/auth/login_screen.dart';
import 'package:mymedialist/screens/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = 'auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              color: const Color(0xFF1e7df0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SvgPicture.asset(
                    "assets/images/logob.svg",
                    width: 140,
                    height: 140,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20, right: 14, left: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    ButtonsTabBar(
                      backgroundColor: const Color(0xFF1e7df0),
                      unselectedBackgroundColor: Colors.white,
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      radius: 20,
                      tabs: const [
                        Tab(
                          text: "Inicio de sesión",
                        ),
                        Tab(
                          text: "Registro",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .68,
                      child: const TabBarView(
                        children: [
                          LoginScreen(),
                          RegisterScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
