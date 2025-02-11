import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/modal_widgets/input_body.dart';
import 'package:mymedialist/screens/create/modal_widgets/input_footer.dart';
import 'package:mymedialist/screens/create/steps/comment_step.dart';
import 'package:mymedialist/screens/create/steps/priority_screen.dart';
import 'package:mymedialist/screens/create/steps/season_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/modals/floating_modal.dart';
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
  late EntertainmentEntityProvider _entityProvider;
  final FocusNode _capsFocusNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentValue = 1;
  final int _maxValue = 64;
  bool openModal = false;

  Future<void> _navigateToNextStep() async {
    try {
      Entertainment.saveField(
        value: !openModal ? _currentValue : int.parse(_formKey.currentState!.fields['num_caps']!.value.toString()),
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
      Redirect.redirectWithLoader(CommentScreen.routeName, context);
    }
  }

  void _executeValidate() {
    if (_formKey.currentState!.fields['num_caps']!.validate()) {
      openModal = true;
      _capsFocusNode.unfocus();
      _navigateToNextStep();
    }
  }

  Future<void> _navigateToPreviousStep() async => (_entityProvider.category == 'Manga') ?
    await Redirect.redirectWithLoader(StatusScreen.routeName, context) :
    await Redirect.redirectWithLoader(SeasonScreen.routeName, context);

  @override
  void initState() {
    super.initState();
    _entityProvider = context.read<EntertainmentEntityProvider>();
    _currentValue = (_maxValue >= context.read<EntertainmentEntityProvider>().sagaData['num_caps']) ?
      context.read<EntertainmentEntityProvider>().sagaData['num_caps'] : 1;
  }

  @override
  void dispose() {
    super.dispose();
    _capsFocusNode.dispose();
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
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const FormTitle(title: '¿Cuántos capítulos tiene?'),
                          const SizedBox(height: 20,),
                          (_maxValue < _entityProvider.sagaData['num_caps']) ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Número actual de capítulos: ${_entityProvider.sagaData['num_caps']}",
                              maxLines: 2,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                          ) :
                          SizedBox(
                            height: 260,
                            child: NumberPicker(
                              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                              selectedTextStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                              itemHeight: 80,
                              infiniteLoop: true,
                              minValue: 1,
                              maxValue: _maxValue,
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
              Positioned(
                bottom: 80,
                right: 24,
                child: Button(
                  text: '+',
                  buttonWidth: 44,
                  buttonHeight: 44,
                  borderRadius: 40,
                  backgroundSplash: Colors.white,
                  background: AppTheme.primary,
                  action: () {
                    FloatingModal.open(
                      title: 'Ingresa el número de capítulos',
                      body: InputBody(
                        formKey: _formKey,
                        inputName: 'num_caps',
                        currentFocusNode: _capsFocusNode
                      ),
                      footer: InputFooter(action: _executeValidate)
                    );
                    _capsFocusNode.requestFocus();
                  }
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}