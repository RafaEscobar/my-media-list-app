import 'package:flutter/material.dart';

class EntityCorousel extends StatelessWidget{
  const EntityCorousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: Image.network(
            'https://lumiere-a.akamaihd.net/v1/images/romulus_payoff_poster_las_bc34960b.jpeg?region=0,0,770,1100',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }

}