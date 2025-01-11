import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/priority_provider.dart';
import 'package:provider/provider.dart';

class PendingsScreen extends StatefulWidget {
  const PendingsScreen({super.key});
  static const String routeName = "pending-screen";

  @override
  State<PendingsScreen> createState() => _PendingsScreenState();
}

class _PendingsScreenState extends State<PendingsScreen> {
  /*
  static const _itemsPerPage = 5;
  final PagingController<int, Map<String, dynamic>> _pagingController = PagingController(firstPageKey: 0);
  */
  final PriorityProvider priorityProvider = navigatorKey.currentState!.context.read<PriorityProvider>();

  @override
  void initState() {
    super.initState();
    /*
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey);
    });
    */
  }

  /*
  Future<void> _fetchPage(int pageKey){

  }
  */

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: ElevatedButton(
          onPressed: () async => await priorityProvider.getPriorities(5),
          child: const Text('Hacer petición')
        ),
      ),
    );
  }
}