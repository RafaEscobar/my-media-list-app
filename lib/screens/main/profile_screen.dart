import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = "profile-screen";

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("Perfil"),
      ),
    );
  }
}