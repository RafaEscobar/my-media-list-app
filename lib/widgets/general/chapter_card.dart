import 'package:flutter/material.dart';
import 'package:mymedialist/models/chapter.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class ChapterCard extends StatelessWidget{
  const ChapterCard({
    super.key,
    required this.chapter
  });
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.primary,
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormTitle(
            title: chapter.name.length > 20 ? "${chapter.name.substring(0, 20)}..." : chapter.name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22),
            maxLines: 1,
          ),
          Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${chapter.score}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22),
              ),
              const Icon(Icons.grade_outlined, color: Colors.white, size: 22,)
            ],
          )
        ],
      ),
    );
  }

}