import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/screens/details/add_chapter/step_one.dart';
import 'package:mymedialist/screens/details/add_chapter/step_three.dart';
import 'package:mymedialist/screens/details/add_chapter/step_two.dart';
import 'package:mymedialist/screens/details/sections/entity_body.dart';
import 'package:mymedialist/screens/details/sections/entity_chapters.dart';
import 'package:mymedialist/screens/details/sections/entity_corousel.dart';
import 'package:mymedialist/screens/details/sections/entity_details_options.dart';
import 'package:mymedialist/screens/details/sections/entity_header.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<EntityChaptersState> _chapterKey = GlobalKey<EntityChaptersState>();

  @override
  void initState() {
    super.initState();
     entity = widget.entity!;
  }

  void _addChapter() {
    context.read<ChapterProvider>().sagaId = entity.id;
    showDialog(
      barrierColor: Colors.black87,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        int currentStep = 0;
        return StatefulBuilder(
          builder: (context, setState) {
            void onNextStep() => setState(() => currentStep++);
            void onPreviousStep() => setState(() => currentStep--);

            return AlertDialog(
              content: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, -1.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _getCurrentStep(currentStep, onNextStep, onPreviousStep),
                ),
            );
          },
        );
      },
    );
  }

  Future<void> _updateCurrentEntity() async {
    Saga newEntity = await context.read<SagaProvider>().getSaga(entity.id);
    setState(() => entity = newEntity);
  }

  Widget _getCurrentStep(int currentStep, VoidCallback onNextStep, VoidCallback onPreviousStep) {
    switch (currentStep) {
      case 0:
        return StepOne(onNextStep,);
      case 1:
        return StepTwo(onNextStep, onPreviousStep,);
      case 2:
        return StepThree(chapterKey: _chapterKey, onPreviousStep: onPreviousStep, updateEntity: _updateCurrentEntity,);
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
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text("Detalles", style: TextStyle(color: Colors.white),),
        actions: [EntityDetailsOptions(
          addChapter: _addChapter,
          addPhoto: () => (),
          edit: () => ()
        )],
      ),
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            context.pop();
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Column(
                spacing: 20,
                children: [
                  EntityHeader(currentEntity: entity,),
                  EntityBody(currentEntity: entity,),
                  EntityCorousel(images: entity.images,),
                  if (entity.type == TypeEnum.saga.name)
                     Column(
                      children: [
                        EntityChapters(key: _chapterKey, sagaId: entity.id),
                        const SizedBox(height: 16,)
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}