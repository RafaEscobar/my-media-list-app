import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/screens/details/sections/entity_body.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:mymedialist/screens/details/sections/entity_header.dart';

class EntityDetailsScreens extends StatefulWidget {
  const EntityDetailsScreens(
    this.entityId, {
    this.type,
    super.key,
  });
  static const String routeName = 'details-screen';
  final String entityId;
  final String? type;

  @override
  State<EntityDetailsScreens> createState() => _EntityDetailsScreensState();
}

class _EntityDetailsScreensState extends State<EntityDetailsScreens> {
  late Entity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              EntityHeader(currentEntity: entity,),
              EntityBody(currentEntity: entity,),
              const EntityCorousel()
            ],
          ),
        ),
      )
    );
  }
}