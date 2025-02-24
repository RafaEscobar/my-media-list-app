import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityBody extends StatelessWidget{
  const EntityBody({
    super.key,
    required this.currentEntity
  });
  final Entity currentEntity;

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        spacing: 22,
        children: [
          FormTitle(title: currentEntity.title, maxLines: 2,),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(currentEntity.category, style: const TextStyle(fontSize: 17, color: Colors.white),),
                const Text("/", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),),
                Text(DateFormat("dd/MM/yy").format(currentEntity.creationDate), style: const TextStyle(fontSize: 17,  color: Colors.white),),
              ],
            ),
          ),
          (currentEntity.status == 'Pendiente' || currentEntity.status == 'En emisión') ?
            Lottie.asset(
              width: 200,
              "assets/animations/live.json",
              renderCache: RenderCache.drawingCommands,
              fit: BoxFit.fitHeight
            ) :
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(currentEntity.comment, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w200,),),
            ),
        ],
      ),
    );
  }
}