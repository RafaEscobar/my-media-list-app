import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:star_menu/star_menu.dart';

class EntityDetailsOptions extends StatelessWidget{
  const EntityDetailsOptions({
    super.key,
    required this.addChapter,
    required this.addPhoto,
    required this.edit,
    required this.controller
  });
  final Function() addChapter;
  final Function() addPhoto;
  final Function() edit;
  final StarMenuController controller;

  @override
  Widget build(BuildContext context){
    final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
    return Container(
      margin: EdgeInsets.only(right: 14),
      child: StarMenu(
        onItemTapped: (index, controller) {
          if (index == 1) {
            controller.closeMenu!();
            addChapter();
          } else if (index == 2){
            controller.closeMenu!();
            addPhoto();
          }
        },
        params: StarMenuParameters(
          shape: MenuShape.linear,
          linearShapeParams: LinearShapeParams(
            angle: 270,
            space: 15,
            alignment: LinearAlignment.left,
          ),
        ),
        items: [
          Tooltip(
            message: "Próximamente",
            key: tooltipKey,
            triggerMode: TooltipTriggerMode.manual,
            showDuration: const Duration(milliseconds: 500),
            child: Button(
              action: () {
                tooltipKey.currentState!.ensureTooltipVisible();
                //actionEdit!();
              },
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
          ),
          Button(
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
          Button(
            icon: Padding(
              padding: const EdgeInsets.all(2),
              child: SvgPicture.asset(
                "assets/icons/upload_image.svg",
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
        child: SvgPicture.asset(
          "assets/icons/utils.svg",
          width: 30,
          height: 30,
          colorFilter:
              const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      )
    );
  }

}