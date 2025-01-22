import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';

class Redirect {
  static void onUnauthorized() => navigatorKey.currentState!.context.goNamed(AuthScreen.routeName);
}