import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Label(text: 'Correo electrónico:', size: 18,),
              Input(
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                hintText: 'example@mail.com',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              SizedBox(height: 40,),
              Label(text: 'Contraseña:', size: 18,),
              Input(
                obscureText: true,
                keyboardType: TextInputType.text,
                hintText: '* * * * * * * *',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                maxLength: 16,
                showMaxLenght: true,
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerRight,
                child: Label(text: '¿Olvidaste tu contraseña?', size: 14, color: Colors.black54, ),
              )
            ],
          ),
          Button(
            action: () => (),
            text: 'Iniciar sesión',
            backgroundSplash: const Color(0xFF3df0fa),
            background: const Color(0xFF1e7df0),
            borderRadius: 20
          )
        ],
      ),
    );
  }
}