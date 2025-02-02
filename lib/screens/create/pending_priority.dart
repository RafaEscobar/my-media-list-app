import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/pending_priority_provider.dart';
import 'package:mymedialist/screens/create/caps_screen.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/widgets/general/priority_card.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class PendingPriority extends StatelessWidget with CancelCreationMixin {
  static const String routeName = 'pending-priority';
  PendingPriority({super.key});
  final MediaProvider _mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();

  void _onPreviousStep() {
    if (_mediaProvider.subtype == 'Saga') {
      (_mediaProvider.thereIsMoreInfo) ?
        navigatorKey.currentState!.context.goNamed(CapsScreen.routeName) :
        navigatorKey.currentState!.context.goNamed(StatusScreen.routeName);
    } else if (_mediaProvider.subtype == 'Media') {
      navigatorKey.currentState!.context.goNamed(StatusScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    PendingPriorityProvider priorityProvider = context.read<PendingPriorityProvider>();
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
                '¿Qué tan prioritario es?',
                style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: priorityProvider.pendingPriorityList.length,
                itemBuilder: (BuildContext context, int index) {
                  return PriorityCard(priority: priorityProvider.pendingPriorityList[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20,)
              ),
              const SizedBox(height: 20,),
              BottomButtons(
                textBtnLeft: 'Regresar',
                actionBtnL: _onPreviousStep,
                onlyOneBtn: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
