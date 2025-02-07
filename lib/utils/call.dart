import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/category_provider.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:mymedialist/provider/post_view_priority_provider.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:provider/provider.dart';

class Call {
  static Future<void> firstCalls() async {
    try {
      final context = navigatorKey.currentState?.context;
      if (context == null) return;
      await context.read<CategoryProvider>().getCategories();
      if (context.mounted) await context.read<StatusProvider>().getStatusList();
      if (context.mounted) await context.read<PendingPriorityProvider>().getPendingPriorities();
      if (context.mounted) await context.read<PostViewPriorityProvider>().getPostViewPriorities();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
