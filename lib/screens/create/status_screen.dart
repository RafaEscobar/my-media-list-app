import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:mymedialist/screens/create/add_image_screen.dart';
import 'package:mymedialist/widgets/general/media_status_card.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StatusScreen extends StatelessWidget with CancelCreationMixin {
  static const String routeName = 'status-screen';
  StatusScreen({super.key});
  final StatusProvider _statusProvider = navigatorKey.currentState!.context.read<StatusProvider>();

  void _previusStep() => navigatorKey.currentState!.context.goNamed(AddImageScreen.routeName);

  @override
  Widget build(BuildContext context) {
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
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text(
                        "¿Cuál es el estatus actual del contenido?",
                        style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: _statusProvider.statusList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 2/2
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return MediaStatusCard(status: _statusProvider.statusList[index]);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: _previusStep,
                  padding: const EdgeInsets.symmetric(vertical: 8),
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