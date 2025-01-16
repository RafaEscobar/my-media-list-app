import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/widgets/general/media_type_card.dart';
import 'package:provider/provider.dart';

class TypeScreen extends StatefulWidget {
  static const String routeName = 'type-screen';
  const TypeScreen({super.key});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  final MediaProvider _mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: 260,
              child: Text(
                '¿Qué quieres vas a calificar?',
                style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 28, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2 /2.4,
                ),
                itemCount: _mediaProvider.types.length,
                itemBuilder: (BuildContext context, int index) {
                  return MediaTypeCard(
                    name: _mediaProvider.types[index]['name'],
                    svgPath: _mediaProvider.types[index]['imageUrl'],
                    categoryId: _mediaProvider.types[index]['categoryId'],
                  );
                },
              ),
                      ),
            )
          ],
        ),
      ),
    );
  }
}