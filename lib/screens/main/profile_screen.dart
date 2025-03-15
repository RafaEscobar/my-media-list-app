import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
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
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          spacing: 380,
          children: [
            const EmptyState(title: 'Próximamente', lottieName: 'soon'),
            Column(
              spacing: 10,
              children: [
                FormTitle(title: "Versión 0.2.0", textSize: 18,),
                ElevatedButton(
                  onPressed: logout,
                  child: const Text('Cerrar sesión')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}