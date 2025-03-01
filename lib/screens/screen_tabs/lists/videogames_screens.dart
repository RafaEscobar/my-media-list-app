import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class VideogamesScreens extends StatefulWidget {
  const VideogamesScreens({super.key});

  @override
  State<VideogamesScreens> createState() => _VideogamesScreensState();
}

class _VideogamesScreensState extends State<VideogamesScreens> {
  final _limit = 10;
  final PagingController<int, Entity> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
  }

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Entity> mediaList = await context.read<MediaProvider>().getMedia(limit: _limit, page: pageKey, categoryId: CategoryEnum.videogames.identifier);
      bool isLastPage = mediaList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(mediaList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(mediaList, nextPageKey);
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
        builderDelegate: PagedChildBuilderDelegate<Entity>(
          itemBuilder: (BuildContext context, Entity game, int index) {
            return Center(
              child: MediaCard(entity: game,),
            );
          },
          noItemsFoundIndicatorBuilder: (context) => const EmptyState(title: 'No hay elementos que mostrar', lottieName: 'empty_state'),
        ),
      ),
    );
  }
}