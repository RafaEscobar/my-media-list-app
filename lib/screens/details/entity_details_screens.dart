import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/screens/details/sections/entity_body.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:mymedialist/screens/details/sections/entity_header.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/button.dart';

class EntityDetailsScreens extends StatefulWidget {
  static const String routeName = 'details-screen';
  const EntityDetailsScreens({
    this.entity,
    super.key,
  });
  final Entity? entity;

  @override
  State<EntityDetailsScreens> createState() => _EntityDetailsScreensState();
}

class _EntityDetailsScreensState extends State<EntityDetailsScreens> {
  late Entity entity;

  @override
  void initState() {
    super.initState();
     entity = widget.entity!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text("Detalles", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              spacing: 20,
              children: [
                EntityHeader(currentEntity: entity,),
                EntityBody(currentEntity: entity,),
                const EntityCorousel()
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        width: 50,
        height: 130,
        child: Column(
          spacing: 14,
          children: [
            Button(
              action: () => (),
              icon: Padding(
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset(
                  "assets/icons/edit.svg",
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              background: AppTheme.primary,
              borderRadius: 50,
              buttonWidth: 50,
              buttonHeight: 50,
            ),
            Button(
              action: () => (),
              icon: Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(
                  "assets/icons/add_chapter.svg",
                  height: 14,
                  width: 14,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              background: AppTheme.primary,
              borderRadius: 50,
              buttonWidth: 50,
              buttonHeight: 50,
            ),
          ],
        ),
      )
    );
  }
}