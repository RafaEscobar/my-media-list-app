import 'package:flutter/material.dart';
import 'package:mymedialist/screens/details/sections/entity_body.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:mymedialist/screens/details/sections/entity_header.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: const Column(
            children: [
              EntityHeader(),
              EntityBody(),
              EntityCorousel()
            ],
          ),
        ),
      )
    );
  }
}