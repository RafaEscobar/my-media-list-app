import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:mymedialist/provider/post_view_priority_provider.dart';
import 'package:mymedialist/screens/create/caps_screen.dart';
import 'package:mymedialist/screens/create/comment_screen.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/priority_card.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class PriorityScreen extends StatelessWidget with CancelCreationMixin {
  static const String routeName = 'priority-screen';
  PriorityScreen({super.key});

  void _onPreviousStep(BuildContext context) {
    try {
      MediaProvider mediaProvider = context.read<MediaProvider>();
      (mediaProvider.isPendingPriority) ? _navigateToPending(context) : _navigateToPostView(context);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _navigateToPending(BuildContext context){
    MediaProvider mediaProvider = context.read<MediaProvider>();
    if (mediaProvider.subtype == 'Saga') {
      (mediaProvider.thereIsMoreInfo) ? context.goNamed(CapsScreen.routeName) : context.goNamed(StatusScreen.routeName);
    } else if (mediaProvider.subtype == 'Media') {
      context.goNamed(StatusScreen.routeName);
    }
  }

  void _navigateToPostView(BuildContext context) => context.goNamed(CommentScreen.routeName);

  @override
  Widget build(BuildContext context) {
    PostViewPriorityProvider postViewProvider = context.read<PostViewPriorityProvider>();
    PendingPriorityProvider priorityProvider = context.read<PendingPriorityProvider>();
    MediaProvider mediaProvider = context.read<MediaProvider>();
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          showModal();
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              Text(
                mediaProvider.isPendingPriority ? '¿Qué tan prioritario es?' : '¿Cuándo darle un vistazo de nuevo?',
                style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: mediaProvider.isPendingPriority ? priorityProvider.pendingPriorityList.length : postViewProvider.postViewPriorityList.length,
                itemBuilder: (BuildContext context, int index) {
                  return PriorityCard(
                    priority: mediaProvider.isPendingPriority ?
                      priorityProvider.pendingPriorityList[index] :
                      postViewProvider.postViewPriorityList[index]
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20,)
              ),
              const SizedBox(height: 20,),
              BottomButtons(
                textBtnLeft: 'Regresar',
                actionBtnL: () => _onPreviousStep(context),
                onlyOneBtn: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
