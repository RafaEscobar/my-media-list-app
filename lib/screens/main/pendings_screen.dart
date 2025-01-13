import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/provider/priority_provider.dart';
import 'package:provider/provider.dart';

class PendingsScreen extends StatefulWidget {
  const PendingsScreen({super.key});
  static const String routeName = "pending-screen";

  @override
  State<PendingsScreen> createState() => _PendingsScreenState();
}

class _PendingsScreenState extends State<PendingsScreen> {
  static const _limit = 5;
  final PagingController<int, Priority> _pagingController = PagingController(firstPageKey: 1);
  final PriorityProvider priorityProvider = navigatorKey.currentState!.context.read<PriorityProvider>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Priority> priorityList = await priorityProvider.getPriorities(
        limit: _limit,
        page: pageKey
      );
      final isLastPage = priorityList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(priorityList);
      } else {
        final nextPageKey = ++pageKey;
        _pagingController.appendPage(priorityList, nextPageKey);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Priority>(
            itemBuilder: (BuildContext context, Priority item, int index) {
              return Container(
                color: Colors.yellow,
                height: 200,
                child: Text("${item.id} ${item.priority}")
              );
            },
          )
        )
      ),
    );
  }
}