import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mymedialist/models/chapter.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/chapter_card.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:provider/provider.dart';

class EntityChapters extends StatefulWidget {
  const EntityChapters({
    super.key,
    required this.sagaId,
  });
  final int sagaId;

  @override
  State<EntityChapters> createState() => EntityChaptersState();
}

class EntityChaptersState extends State<EntityChapters> {
  final int _limit = 50;
  final PagingController<int, Chapter> _pagingController = PagingController(firstPageKey: 1);
  bool isAscOrder = false;

  Future<void> _fetchPage({ required int pageKey }) async {
    try {
      List<Chapter> currentList = await context.read<ChapterProvider>().getChapters(
        context,
        limit: _limit,
        pageKey: pageKey,
        sagaId: widget.sagaId,
        ascOrder: isAscOrder,
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

  void refreshChapters() => _pagingController.refresh();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey){
      _fetchPage(pageKey: pageKey);
    });
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
              GestureDetector(
                onTap: () {
                  setState(() => isAscOrder = !isAscOrder);
                  _pagingController.refresh();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/${isAscOrder ? 'asc' : 'desc'}.svg",
                    height: 18,
                    width: 18,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                ),
              ),
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