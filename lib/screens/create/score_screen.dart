import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  static const String routeName = 'score-screen';
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Score'),
    );
  }
}