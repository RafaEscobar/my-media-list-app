import 'package:flutter/material.dart';

class DetailsScreens extends StatelessWidget {
  const DetailsScreens({
    super.key,
    required this.entityId
  });
  static const String routeName = 'details-screen';
  final int entityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Details screen $entityId"),
      ),
    );
  }
}