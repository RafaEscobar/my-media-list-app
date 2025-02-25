import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/theme/app_theme.dart';

class MainHead extends StatelessWidget {
  const MainHead({
    super.key,
    this.withoutSearch = true
  });
  final bool withoutSearch;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/logo.svg",
            height: 46,
            width: 46,
            colorFilter: const ColorFilter.mode(AppTheme.primary, BlendMode.srcIn),
          ),
          Visibility(
            visible: withoutSearch,
            child: Tooltip(
              message: "Próximamente",
              key: tooltipKey,
              triggerMode: TooltipTriggerMode.manual,
              showDuration: const Duration(milliseconds: 500),
              child: GestureDetector(
                child: const Icon(Icons.search_sharp, size: 34,),
                onTap: () => tooltipKey.currentState!.ensureTooltipVisible(),
              ),
            )
          )
        ],
      ),
    );
  }
}