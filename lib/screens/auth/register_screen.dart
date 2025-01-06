import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              Label(text: 'Nombre:', size: 18,),
              Input(
                obscureText: false,
                keyboardType: TextInputType.text,
                hintText: 'Raúl',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              SizedBox(height: 30,),
              Label(text: 'Apellidos:', size: 18,),
              Input(
                obscureText: false,
                keyboardType: TextInputType.text,
                hintText: 'Casillas',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              SizedBox(height: 30,),
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
              ),
            ],
          ),
          Button(
            action: () => (),
            text: 'Registrarme',
            backgroundSplash: const Color(0xFF3df0fa),
            background: const Color(0xFF1e7df0),
            borderRadius: 20
          )
        ],
      ),
    );
  }
}