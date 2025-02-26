import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/button.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context){
    return SizedBox(
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
    );
  }

}