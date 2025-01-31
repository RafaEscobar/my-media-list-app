import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/category_provider.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/widgets/general/bottom_sheet_widget.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class Call {
  static Future<void> firstCalls() async {
    final context = navigatorKey.currentState?.context;
    if (context == null) return;
    await context.read<CategoryProvider>().getCategories();
    if (context.mounted) await context.read<StatusProvider>().getStatusList();
  }

}
