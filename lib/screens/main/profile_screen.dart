import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> logout() async {
    navigatorKey.currentState!.context.read<AppProvider>().logout();
    await Loader().runLoad(() async => await Future.delayed(const Duration(seconds: 1)));
    if (mounted) navigatorKey.currentState!.context.goNamed(AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: logout,
              child: const Text('Cerrar sesión')
            )
          ],
        ),
      ),
    );
  }
}