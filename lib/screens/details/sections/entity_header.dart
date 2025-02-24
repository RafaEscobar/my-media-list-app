import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    super.key,
    required this.currentEntity
  });
  final Entity currentEntity;

  @override
  Widget build(BuildContext context){
    dynamic nose = currentEntity;
    print(nose);
    return SizedBox(
      height: 230,
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  currentEntity.image,
                  fit: BoxFit.contain,
                )
              )
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormTitle(title: 'Calificación', textSize: 24,),
                    (currentEntity.score != 0) ?
                    Row(
                      children: [
                        Text("${currentEntity.score}", style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),),
                        const Icon(Icons.grade_outlined)
                      ],
                    ) : const Text("---"),
                  ],
                ),
                currentEntity is Saga && currentEntity.position != null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormTitle(title: 'Posición', textSize: 20,),
                      Text('#${currentEntity.position}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    ],
                  ) : Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormTitle(title: 'Estatus', textSize: 20,),
                    Text(currentEntity.status, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  ],
                ),
                currentEntity is Saga ?
                Row(
                  spacing: 10,
                  children: [
                    (currentEntity as Saga).numCaps != 0 ?
                    const Text('Capitulos: 12', style: TextStyle(fontSize: 12), maxLines: 2,) : Container(),
                    ((currentEntity as Saga).season != 0) ?
                    const Text('Temporadas: 2', style: TextStyle(fontSize: 12), maxLines: 2,) : Container()
                  ],
                ) : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

}