import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/models/media.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/main/details_screens.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class PriorityCard extends StatelessWidget {
  const PriorityCard({super.key, required this.priority});
  final Priority priority;

  Future<void> _onSelectPriority(BuildContext context) async {
    try {
      context.read<MediaProvider>().pendingPriorityId = priority.id;
      if (context.read<MediaProvider>().type == 'Media') {
        Media(
          title: context.read<MediaProvider>().title,
          score: context.read<MediaProvider>().score,
          comment: context.read<MediaProvider>().comment,
          categoryId: context.read<MediaProvider>().categoryId,
          statusId: context.read<MediaProvider>().status.id,
          pendingPriorityId: context.read<MediaProvider>().pendingPriorityId,
          postViewPriorityId: context.read<MediaProvider>().postViewPriority,
        );
      } else if (context.read<MediaProvider>().type == 'Saga') {
        Saga(
          title: context.read<MediaProvider>().title,
          numCaps: context.read<MediaProvider>().numCaps,
          season: context.read<MediaProvider>().season,
          comment: context.read<MediaProvider>().comment,
          categoryId: context.read<MediaProvider>().categoryId,
          statusId: context.read<MediaProvider>().status.id,
          pendingPriorityId: context.read<MediaProvider>().pendingPriorityId,
          postViewPriorityId: context.read<MediaProvider>().postViewPriority
        );
      }
      if (context.mounted) context.goNamed(DetailsScreens.routeName);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _onSelectPriority(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(
                      priority.priority,
                      style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 22, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        maxLines: 2,
                        priority.description,
                        style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 16, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}