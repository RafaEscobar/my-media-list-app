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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width,
            color: const Color(0xFF1e7df0),
            child: Column(
              children: [
                const SizedBox(height: 40,),
                SvgPicture.asset(
                  "assets/images/logob.svg",
                  width: 140,
                  height: 140,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                   BoxShadow(
                    color: Colors.white60,
                    blurRadius: 4,
                    offset: Offset(5, 5),
                  ),
                ]
              ),
              width: size.width * .84,
              height: size.height * .7,
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30, right: 20, left: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 14,),
                      ButtonsTabBar(
                        backgroundColor: Colors.white,
                        unselectedBackgroundColor: const Color(0xFF1e7df0),
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                        unselectedLabelStyle: const TextStyle(color: Colors.white),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        radius: 20,
                        tabs: const [
                          Tab(
                              text: "Iniciar sesión",
                            ),
                            Tab(
                              text: "Registrarme",
                            ),
                        ]
                      ),
                      const Expanded(
                        child: TabBarView(
                            children: [
                              LoginScreen(),
                              RegisterScreen()
                            ]
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
