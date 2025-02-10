import 'package:flutter/material.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/priority_screen.dart';
import 'package:mymedialist/screens/create/steps/score_step.dart';
import 'package:mymedialist/screens/create/steps/season_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
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
  late EntertainmentEntityProvider _entityProvider;

  Future<void> _navigateToNextStep() async {
    try {
      Entertainment.saveField(
        value: _currentValue,
        fieldName: 'num_caps'
      );
      _handleRedirect();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  Future<void> _handleRedirect() async {
    _entityProvider.isPendingPriority = Entertainment.isInProcessStatus();
    if (_entityProvider.isPendingPriority) {
      Redirect.redirectWithLoader(PriorityScreen.routeName, context);
    } else {
      Redirect.redirectWithLoader(ScoreScreen.routeName, context);
    }
  }

  Future<void> _navigateToPreviousStep() async => (_entityProvider.category == 'Manga') ?
    await Redirect.redirectWithLoader(StatusScreen.routeName, context) :
    await Redirect.redirectWithLoader(SeasonScreen.routeName, context);

  @override
  void initState() {
    super.initState();
    _entityProvider = context.read<EntertainmentEntityProvider>();
  }

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
                      const FormTitle(title: '¿Cuántos capítulos tiene?'),
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