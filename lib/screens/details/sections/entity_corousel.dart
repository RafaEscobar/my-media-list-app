import 'package:flutter/material.dart';

class EntityCorousel extends StatelessWidget{
  const EntityCorousel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Aquí va ira el carrousel"),
        SizedBox(
          width: 300,
          child: Placeholder()
        ),
        SizedBox(height: 20,)
      ],
    );
  }

}