import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/label.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Label(text: 'Correo electrónico:', size: 18,),
          
        ],
      ),
    );
  }
}