import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class EntityBody extends StatelessWidget{
  const EntityBody({super.key});

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        spacing: 30,
        children: [
          FormTitle(title: 'Titulo de la media', maxLines: 2,),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Categoria", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.white),),
                Text("/", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),),
                Text("17/02/2025", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.white),),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('LORE dwndeionde iednewo ndwedn ewdionew doinewdni ewediewndiewndewid diewdo iewndinwe ednewdnewi odnewiodew iond ewinod wiiendd oiewnd oiewnnd eoiwn ednio n', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300,),),
          ),
          Lottie.asset(
            width: 200,
            "assets/animations/live.json",
            renderCache: RenderCache.drawingCommands,
            fit: BoxFit.fitHeight
          ),
        ],
      ),
    );
  }
}