import 'package:flutter/material.dart';

class DetailsScreens extends StatelessWidget {
  const DetailsScreens({super.key});
  static const String routeName = 'details-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Details screen"),
      ),
    );
  }
}