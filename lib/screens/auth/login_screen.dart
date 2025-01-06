import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/input.dart';
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
          Input(
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            hintText: 'example@mail.com',
            contentPadding: EdgeInsets.symmetric(vertical: 2),
            maxLength: 60,
          ),
          SizedBox(height: 30,),
          Label(text: 'Contraseña:', size: 18,),
          Input(
            obscureText: true,
            keyboardType: TextInputType.text,
            hintText: '* * * * * * * *',
            contentPadding: EdgeInsets.symmetric(vertical: 2),
            maxLength: 16,
            showMaxLenght: true,
          )
        ],
      ),
    );
  }
}