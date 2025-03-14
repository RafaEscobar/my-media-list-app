import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, this.entity});
  final Entity? entity;

  @override
  Widget build(BuildContext context) {
    return entity != null ? SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipOval(
              child: Transform.scale(
                scale: 1.6,
                child: Image.network(
                  entity!.image,
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                )
              ),
            ),
          ),
          SizedBox(height: 4,),
          SizedBox(
            width: 66,
            child: FormTitle(
              title: (entity!.title.length >= 16) ? "${entity!.title.substring(0, 16)}..." : entity!.title,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppTheme.primary),
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormTitle(
                title: "${entity!.score}",
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppTheme.primary),
              ),
              Icon(Icons.grade_outlined, size: 14, color: AppTheme.primary)
            ],
          )
        ],
      ),
    ) :  Image.asset(
      "assets/images/empty.png",
      fit: BoxFit.fill,
      height: 80,
      width: 80,
    );
  }
}