import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
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
      SagaProvider sagaProvider = context.read<SagaProvider>();
      List<Saga> currentList = await sagaProvider.getSagas(limit: _limit, page: pageKey, categoryId: CategoryEnum.series.identifier);
      bool isLastPage = currentList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(currentList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(currentList, nextPageKey);
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
        builderDelegate: PagedChildBuilderDelegate<Saga>(
          itemBuilder: ( BuildContext context, Saga serie, int index) {
            return Center(
              child: MediaCard(entity: serie),
            );
          },
          noItemsFoundIndicatorBuilder: (context) => const EmptyState(title: 'No hay elementos que mostrar', lottieName: 'empty_state'),
        ),
      ),
    );
  }
}