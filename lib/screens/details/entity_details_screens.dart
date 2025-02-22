import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:provider/provider.dart';

class EntityDetailsScreens extends StatefulWidget {
  const EntityDetailsScreens({
    this.entityId,
    this.type,
    this.entity,
    super.key,
  });
  static const String routeName = 'details-screen';
  final String? entityId;
  final String? type;
  final Entity? entity;

  @override
  State<EntityDetailsScreens> createState() => _EntityDetailsScreensState();
}

class _EntityDetailsScreensState extends State<EntityDetailsScreens> {
  late Entity entity;

  void _getEntity() {
    try {
      dynamic nose = widget.entity;
      print(nose);
      if (widget.entity != null) entity = widget.entity!;
      entity = widget.type == TypeEnum.media.name ?
        context.read<MediaProvider>().mediaList.firstWhere((media) => media.id == int.parse(widget.entityId!)) :
        context.read<SagaProvider>().sagaList.firstWhere((saga) => saga.id == int.parse(widget.entityId!));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getEntity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              //EntityHeader(currentEntity: entity,),
              //EntityBody(currentEntity: entity,),
              const EntityCorousel()
            ],
          ),
        ),
      )
    );
  }
}