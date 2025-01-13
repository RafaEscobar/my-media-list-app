import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/media.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  final int _limit = 10;
  final PagingController<int, Media> _pagingController = PagingController(firstPageKey: 1);
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
      List<Media> serieList = await _mediaProvider.getMedia(
        limit: _limit,
        page: pageKey,
        categoryId: CategoryEnum.series.identifier
      );
      bool isLastPage = serieList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(serieList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(serieList, nextPageKey);
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
        builderDelegate: PagedChildBuilderDelegate<Media>(itemBuilder: ( BuildContext context, Media serie, int index) {
          return Center(
            child: MediaCard(
              imagePath: serie.imagePath.replaceAll('http://localhost:8000', 'https://8bf7-187-235-135-111.ngrok-free.app'),
              name: serie.title,
              score: serie.score
            ),
          );
        }),
      ),
    );
  }
}