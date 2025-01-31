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
  AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();
  Future<void> logout() async {
    bool? isUnloged;
    await Loader.runLoad(
      asyncFunction: () async => isUnloged = await navigatorKey.currentState!.context.read<AppProvider>().makeLogout(),
      secondsDelayed: 2
    );
    if (!mounted) return;
    if (isUnloged!) navigatorKey.currentState!.context.goNamed(AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Text(appProvider.userInfo.name),
            Text(appProvider.userInfo.email),
            Text("${appProvider.userInfo.id}"),
            SelectableText(appProvider.userInfo.token),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Cerrar sesión')
            ),
          ],
        ),
      ),
    );
  }
}