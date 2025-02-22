import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class MangasScreen extends StatefulWidget {
  const MangasScreen({super.key});

  @override
  State<MangasScreen> createState() => _MangasScreenState();
}

class _MangasScreenState extends State<MangasScreen> {
  final int _limit = 10;
  final PagingController<int, Saga> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
  }

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Saga> sagaList = await context.read<SagaProvider>().getSaga(limit: _limit, page: pageKey, categoryId: CategoryEnum.mangas.identifier);
      bool isLastPage = sagaList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(sagaList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(sagaList, nextPageKey);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PagedGridView(
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2/2.6
        ),
        builderDelegate: PagedChildBuilderDelegate<Saga>(itemBuilder: ( BuildContext context, Saga manga, int index) {
          return Center(
            child: MediaCard(entity: manga),
          );
        }),
      ),
    );
  }
}