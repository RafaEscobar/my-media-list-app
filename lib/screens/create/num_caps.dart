import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/priority_screen.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/screens/create/season_screen.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class NumCaps extends StatefulWidget {
  const NumCaps({super.key});
  static const String routeName = 'num-caps';

  @override
  State<NumCaps> createState() => _NumCapsState();
}

class _NumCapsState extends State<NumCaps> with CancelCreationMixin {
  int _currentValue = 1;

  Future<void> _navigateToNextStep() async {
    try {
      MediaProvider mediaProvider = context.read<MediaProvider>();
      mediaProvider.numCaps = _currentValue;
      if (mediaProvider.status.status == 'Pendiente' || mediaProvider.status.status == 'En emisión') {
        mediaProvider.isPendingPriority = true;
        await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 300)) );
        if (mounted) context.goNamed(PriorityScreen.routeName);
      } else {
        await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 300)) );
        if (mounted) context.goNamed(ScoreScreen.routeName);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _navigateToPreviousStep() => (context.read<MediaProvider>().type == 'Manga') ? context.goNamed(StatusScreen.routeName) : context.goNamed(SeasonScreen.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          showModal();
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "¿Cuántos capítulos tiene?",
                        style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 260,
                        child: NumberPicker(
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                          selectedTextStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                          itemHeight: 80,
                          infiniteLoop: true,
                          minValue: 1,
                          maxValue: 500,
                          value: _currentValue,
                          onChanged: (value) => setState(() => _currentValue = value),
                        ),
                      )
                    ],
                  )
                ),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: _navigateToPreviousStep,
                  textBtnRight: 'Continuar',
                  actionBtnR: _navigateToNextStep,
                  margin: const EdgeInsets.only(bottom: 10),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}