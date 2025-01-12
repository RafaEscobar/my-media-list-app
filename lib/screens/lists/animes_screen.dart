import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/media.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/widgets/general/media_card.dart';
import 'package:provider/provider.dart';

class AnimesScreen extends StatefulWidget {
  const AnimesScreen({super.key});

  @override
  State<AnimesScreen> createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  final int _limit = 5;
  final PagingController<int, Media> _pagingController = PagingController(firstPageKey: 1);
  final MediaProvider mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
  }

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Media> mediaList = await mediaProvider.getMedia(limit: _limit, page: pageKey);
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
      child: PagedGridView<int, Media>(
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2/2.6
        ),
        builderDelegate: PagedChildBuilderDelegate<Media>(itemBuilder: (BuildContext context, Media media, int index) {
          return Center(
            child: MediaCard(
              imagePath: media.imagePath.replaceAll('http://localhost:8000', 'https://94fa-207-248-115-158.ngrok-free.app'),
              name: media.title,
              score: media.score,
            ),
          );
        },)
      )
    );
  }
}
