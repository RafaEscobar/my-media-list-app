import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/steps/caps_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});
  static const String routeName = 'season-screen';

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> with CancelCreationMixin {
  int _currentValue = 1;

  Future<void> _navigateToNextStep() async {
    try {
      context.read<MediaProvider>().season = _currentValue;
      await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 300)) );
      if (mounted) context.goNamed(NumCaps.routeName);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _navigateToPreviousStep() => context.goNamed(StatusScreen.routeName);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "¿Qué temporada es?",
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
                          maxValue: 50,
                          value: _currentValue,
                          onChanged: (value) => setState(() => _currentValue = value),
                        ),
                      )
                    ],
                  ),
                ),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: _navigateToPreviousStep,
                  textBtnRight: 'Continuar',
                  actionBtnR: _navigateToNextStep,
                  margin: const EdgeInsets.only(bottom: 20),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}