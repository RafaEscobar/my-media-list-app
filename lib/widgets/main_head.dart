import 'package:flutter/material.dart';

class MainHead extends StatelessWidget {
  const MainHead({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo.png", height: 60, width: 60),
          Tooltip(
            message: "Próximamente",
            key: tooltipKey,
            triggerMode: TooltipTriggerMode.manual,
            showDuration: const Duration(milliseconds: 500),
            child: GestureDetector(
              child: const Icon(Icons.search_sharp, size: 34,),
              onTap: () => tooltipKey.currentState!.ensureTooltipVisible(),
            ),
          )
        ],
      ),
    );
  }
}