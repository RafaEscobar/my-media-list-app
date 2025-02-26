import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/screens/details/add_chapter/step_one.dart';
import 'package:mymedialist/screens/details/add_chapter/step_three.dart';
import 'package:mymedialist/screens/details/add_chapter/step_two.dart';
import 'package:mymedialist/screens/details/sections/entity_body.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:mymedialist/screens/details/sections/entity_header.dart';
import 'package:mymedialist/screens/details/sections/floating_buttons.dart';
import 'package:mymedialist/theme/app_theme.dart';

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
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
     entity = widget.entity!;
  }

  void _addChapter() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: AnimatedSwitcher(
                duration: const Duration(microseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child,);
                },
                child: _getCurrentStep(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _getCurrentStep() {
    switch (currentStep) {
      case 0:
        return const StepOne();
      case 1:
        return const StepTwo();
      case 2:
        return const StepThree();
      default:
        return Container();
    }
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
      floatingActionButton: FloatingButtons(
        actionAddChapter: _addChapter,
        actionEdit: () => (),
      )
    );
  }
}