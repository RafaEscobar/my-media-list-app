import 'package:flutter/material.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({super.key, required this.currentEntity});
  final Entity currentEntity;

  @override
  Widget build(BuildContext context){
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
                  'https://lumiere-a.akamaihd.net/v1/images/romulus_payoff_poster_las_bc34960b.jpeg?region=0,0,770,1100',
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
                    Row(
                      children: [
                        Text("${currentEntity.score}", style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),),
                        const Icon(Icons.grade_outlined)
                      ],
                    ),
                  ],
                ),
                currentEntity is Saga && currentEntity.position != null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormTitle(title: 'Posición', textSize: 20,),
                      Text('#${currentEntity.position}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ],
                  ) : Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormTitle(title: 'Estatus', textSize: 20,),
                    Text(currentEntity.status, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  ],
                ),
                const Row(
                  spacing: 10,
                  children: [
                    Text('Capitulos: 12', style: TextStyle(fontSize: 12), maxLines: 2,),
                    Text('Temporadas: 2', style: TextStyle(fontSize: 12), maxLines: 2,),
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