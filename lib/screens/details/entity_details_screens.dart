import 'package:flutter/material.dart';

class EntityDetailsScreens extends StatelessWidget {
  const EntityDetailsScreens({
    super.key,
    this.entityId
  });
  static const String routeName = 'details-screen';
  final int? entityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: const Column(
          children: [
            
          ],
        ),
      )
    );
  }
}