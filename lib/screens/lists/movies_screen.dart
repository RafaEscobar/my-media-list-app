import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final int _limit = 10;
  final PagingController<int, Entity> _pagingController = PagingController(firstPageKey: 1);
  final MediaProvider _mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
  }

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      MediaProvider mediaProvider = context.read<MediaProvider>();
      await _mediaProvider.getMedia(
        limit: _limit,
        page: pageKey,
        categoryId: CategoryEnum.movies.identifier
      );
      bool isLastPage = mediaProvider.mediaList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(mediaProvider.mediaList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(mediaProvider.mediaList, nextPageKey);
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
        builderDelegate: PagedChildBuilderDelegate<Entity>(itemBuilder: (BuildContext context, Entity movie, int index) {
          return Center(
            child: MediaCard(entity: movie),
          );
        }),
      ),
    );
  }
}