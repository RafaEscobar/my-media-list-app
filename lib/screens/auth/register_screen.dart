import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _lastNFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _lastNFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              const Label(text: 'Nombre:', size: 18,),
              Input(
                name: 'name',
                focusNode: _nameFocusNode,
                obscureText: false,
                keyboardType: TextInputType.text,
                hintText: 'Raúl',
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              const SizedBox(height: 30,),
              const Label(text: 'Apellidos:', size: 18,),
              Input(
                name: 'last_name',
                focusNode: _lastNFocusNode,
                obscureText: false,
                keyboardType: TextInputType.text,
                hintText: 'Casillas',
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              const SizedBox(height: 30,),
              const Label(text: 'Correo electrónico:', size: 18,),
              Input(
                name: 'email',
                focusNode: _emailFocusNode,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                hintText: 'example@mail.com',
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                maxLength: 60,
              ),
              const SizedBox(height: 30,),
              const Label(text: 'Contraseña:', size: 18,),
              Input(
                name: 'password',
                focusNode: _passwordFocuesNode,
                obscureText: true,
                keyboardType: TextInputType.text,
                hintText: '* * * * * * * *',
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
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