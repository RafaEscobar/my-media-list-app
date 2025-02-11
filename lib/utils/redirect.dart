import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/auth/auth_screen.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:provider/provider.dart';

class Redirect {
  static void onUnauthorized() {
    navigatorKey.currentState!.context.read<AppProvider>().localLogout();
    navigatorKey.currentState!.context.goNamed(AuthScreen.routeName);
  }

  static Future<void> redirectWithLoader(String routeName, BuildContext context, {Map<String, String> params = const {}}) async {
    await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 400)), secondsDelayed: 0);
    if (context.mounted) context.goNamed(routeName, pathParameters: params);
  }
}