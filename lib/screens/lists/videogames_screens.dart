import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/saga_provider.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class VideogamesScreens extends StatefulWidget {
  const VideogamesScreens({super.key});

  @override
  State<VideogamesScreens> createState() => _VideogamesScreensState();
}

class _VideogamesScreensState extends State<VideogamesScreens> {
  final _limit = 10;
  final PagingController<int, Saga> _pagingController = PagingController(firstPageKey: 1);
  final SagaProvider _sagaProvider = navigatorKey.currentState!.context.read<SagaProvider>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
  }

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Saga> gameList = await _sagaProvider.getSaga(
        limit: _limit,
        page: pageKey,
        categoryId: CategoryEnum.videogames.identifier
      );
      bool isLastPage = gameList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(gameList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(gameList, nextPageKey);
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
        builderDelegate: PagedChildBuilderDelegate<Saga>(itemBuilder: (BuildContext context, Saga game, int index) {
          return Center(
            child: MediaCard(
              imagePath: game.image.replaceAll('http://localhost:8000', 'https://8bf7-187-235-135-111.ngrok-free.app'),
              name: game.title,
              score: game.score
            ),
          );
        }),
      ),
    );
  }
}