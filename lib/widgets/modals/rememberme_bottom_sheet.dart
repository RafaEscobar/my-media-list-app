import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:mymedialist/widgets/general/button.dart';

class RemembermeBottomSheet extends StatelessWidget {
  const RemembermeBottomSheet({super.key});

  void buttonsAction({bool isAccept = true}){
    Navigator.pop(navigatorKey.currentState!.context);
    if (isAccept) Preferences.rememberme = true;
    navigatorKey.currentState!.context.goNamed(MainNavigation.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "¿Deseas que recordemos tus credenciales la próxima vez?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  text: 'No',
                  background: Colors.red.shade600,
                  textColor: Colors.white,
                  backgroundSplash: Colors.red.shade200,
                  action: () => buttonsAction(isAccept: false),
                  buttonWidth: 140,
                  borderRadius: 20,
                ),
                Button(
                  text: 'Sí',
                  background: Colors.blue.shade600,
                  textColor: Colors.white,
                  backgroundSplash: Colors.blue.shade200,
                  action: buttonsAction,
                  buttonWidth: 140,
                  borderRadius: 20,
                )
              ],
            ),
        ],
      ),
    );
  }
}