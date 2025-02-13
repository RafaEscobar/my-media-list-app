import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityDetailsScreens extends StatelessWidget {
  const EntityDetailsScreens({
    super.key,
    required this.entityId
  });
  static const String routeName = 'details-screen';
  final int entityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            SizedBox(
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormTitle(title: 'Calificación', textSize: 24,),
                            Row(
                              children: [
                                Text('10', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),),
                                Icon(Icons.grade_outlined)
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormTitle(title: 'Posición', textSize: 20,),
                            Text('10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormTitle(title: 'Estatus', textSize: 20,),
                            Text('10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
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
            )
          ],
        ),
      )
    );
  }
}