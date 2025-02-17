import 'package:flutter/material.dart';
import 'package:mymedialist/screens/details/entity/entity_body.dart';
import 'package:mymedialist/screens/details/entity/entity_header.dart';

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
            EntityHeader(),
            EntityBody()
          ],
        ),
      )
    );
  }
}