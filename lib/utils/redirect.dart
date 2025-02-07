import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class Redirect {
  static void onUnauthorized() {
    navigatorKey.currentState!.context.read<AppProvider>().localLogout();
    navigatorKey.currentState!.context.goNamed(AuthScreen.routeName);
  }
}