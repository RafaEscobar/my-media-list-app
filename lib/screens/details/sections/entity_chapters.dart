import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/models/chapter.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/chapter_card.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:provider/provider.dart';

class EntityChapters extends StatefulWidget {
  const EntityChapters({
    super.key,
    required this.sagaId
  });
  final int sagaId;

  @override
  State<EntityChapters> createState() => _EntityChaptersState();
}

class _EntityChaptersState extends State<EntityChapters> {
  final int _limit = 50;
  final PagingController<int, Chapter> _pagingController = PagingController(firstPageKey: 1);

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Chapter> currentList = await context.read<ChapterProvider>().getChapters(
        context,
        limit: _limit,
        pageKey: pageKey,
        sagaId: widget.sagaId

      );
      bool isLastPage = currentList.length < _limit;
      if (isLastPage) {
        _pagingController.appendLastPage(currentList);
      } else {
        int nextPageKey = ++pageKey;
        _pagingController.appendPage(currentList, nextPageKey);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FormTitle(title: "Capítulos"),
              IconButton(
                onPressed: () => (),
                icon: const Icon(Icons.filter_list)
              )
            ],
          ),
          Expanded(
            child: PagedListView(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (BuildContext context, Chapter item, int index) => ChapterCard(chapter: item),
              )
            ),
          )
        ],
      ),
    );
  }
}