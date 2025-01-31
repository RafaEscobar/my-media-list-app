import 'package:flutter/material.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});
  static const String routeName = 'season-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Season screen')),
    );
  }
}