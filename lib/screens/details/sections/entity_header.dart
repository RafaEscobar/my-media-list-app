import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    super.key,
    required this.currentEntity
  });
  final Entity currentEntity;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 310,
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(
                  width: 170,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        width: 170,
                        "https://img.thegoodocs.com/templates/preview/aesthetic-indie-movie-poster-163161.webp",
                        fit: BoxFit.contain,
                      )
                    )
                  ),
                ),
                Container(
                  width: 170,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    currentEntity.status,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 16,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    const FormTitle(title: 'Calificación', textSize: 24,),
                    (currentEntity.score != 0) ?
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 2,
                        children: [
                          Text("${currentEntity.score}", style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600, color: Colors.white),),
                          const Icon(Icons.grade_outlined, color: Colors.white)
                        ],
                      ),
                    ) : const Text("---"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    const FormTitle(title: 'Prioridad', textSize: 21,),
                    Text(
                      "${(currentEntity.status == 'Pendiente' || currentEntity.status == 'En emisión') ? currentEntity.pendingPriority : currentEntity.postViewPriority}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                if (currentEntity is Saga && currentEntity.position != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormTitle(title: 'Posición', textSize: 20,),
                      Text('#${currentEntity.position}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    ],
                  ),
                if (currentEntity is Saga)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        "Capitulos: ${ (currentEntity as Saga).numCaps != 0 ? (currentEntity as Saga).numCaps : '-'}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        maxLines: 2,
                      ),
                      Text(
                        "Temporadas: ${((currentEntity as Saga).season != 0) ? (currentEntity as Saga).season : '-'}",
                        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w300),
                        maxLines: 2,
                      )
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

}