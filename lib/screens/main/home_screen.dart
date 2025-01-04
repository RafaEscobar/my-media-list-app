import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key});
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return const SizedBox(
      child: Center(
        child: Text("Inicio"),
      ),
    );
  }
}