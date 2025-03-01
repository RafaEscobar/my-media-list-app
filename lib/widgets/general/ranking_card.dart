import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class RankingCard extends StatelessWidget{
  const RankingCard({super.key, required this.entity});
  final Entity entity;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30)
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 16,
            children: [
              SizedBox(
                height: 36,
                width: 36,
                child: ClipOval(
                  child: Transform.scale(
                    scale: 1.6,
                    child: Image.network(
                      entity.image,
                      fit: BoxFit.fill,
                      height: 36,
                      width: 36,
                    ),
                  ),
                ),
              ),
              FormTitle(title: entity.title.length > 13 ? "${entity.title.substring(0, 13)}..." : entity.title, textSize: 18,)
            ],
          ),
          Row(
            spacing: 2,
            children: [
              FormTitle(title: "${entity.score}", style: TextStyle(color: AppTheme.primary, fontSize: 18, fontWeight: FontWeight.w300),),
              Icon(Icons.grade_outlined, color: AppTheme.primary, size: 17)
            ],
          )
        ],
      ),
    );
  }

}