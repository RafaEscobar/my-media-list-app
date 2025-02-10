import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:mymedialist/provider/post_view_priority_provider.dart';
import 'package:mymedialist/screens/create/steps/caps_step.dart';
import 'package:mymedialist/screens/create/steps/comment_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/priority_card.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class PriorityScreen extends StatelessWidget with CancelCreationMixin {
  static const String routeName = 'priority-screen';
  PriorityScreen({super.key});

  void _onPreviousStep(BuildContext context) {
    try {
      (context.read<EntertainmentEntityProvider>().isPendingPriority) ? _navigateToPending(context) : _navigateToPostView(context);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  Future<void> _navigateToPending(BuildContext context) async {
    EntertainmentEntityProvider entityProvider = context.read<EntertainmentEntityProvider>();
    if (entityProvider.type == TypeEnum.saga.name) {
      await Redirect.redirectWithLoader(
        entityProvider.shouldAddMoreInfo ? NumCaps.routeName : StatusScreen.routeName,
        context
      );
    } else if (entityProvider.type == TypeEnum.media.name) {
      await Redirect.redirectWithLoader(StatusScreen.routeName, context);
    }
  }

  Future<void> _navigateToPostView(BuildContext context) async => await Redirect.redirectWithLoader(CommentScreen.routeName, context);

  @override
  Widget build(BuildContext context) {
    PostViewPriorityProvider postViewProvider = context.read<PostViewPriorityProvider>();
    PendingPriorityProvider priorityProvider = context.read<PendingPriorityProvider>();
    EntertainmentEntityProvider entityProvider = context.read<EntertainmentEntityProvider>();
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          showModal();
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FormTitle(title: entityProvider.isPendingPriority ? '¿Qué tan prioritario es?' : '¿Cuándo darle un vistazo de nuevo?'),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: entityProvider.isPendingPriority ? priorityProvider.pendingPriorityList.length : postViewProvider.postViewPriorityList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PriorityCard(
                          priority: entityProvider.isPendingPriority ?
                            priorityProvider.pendingPriorityList[index] :
                            postViewProvider.postViewPriorityList[index]
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 20,)
                    ),
                  ],
                ),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: () => _onPreviousStep(context),
                  onlyOneBtn: true,
                  margin: const EdgeInsets.only(bottom: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
