import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/modal_widgets/input_body.dart';
import 'package:mymedialist/screens/create/modal_widgets/input_footer.dart';
import 'package:mymedialist/screens/create/steps/caps_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/modals/floating_modal.dart';
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
  final FocusNode _seasonFocusNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  late int _currentValue;
  final int _maxValue = 12;
  bool openModal = false;

  Future<void> _navigateToNextStep() async {
    try {
      Entertainment.saveField(
        value: !openModal ? _currentValue : int.parse(_formKey.currentState!.fields['season']!.value.toString()),
        fieldName: 'season'
      );
      await Redirect.redirectWithLoader(NumCaps.routeName, context);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  Future<void> _navigateToPreviousStep() async => Redirect.redirectWithLoader(StatusScreen.routeName, context);

  void _executeValidate() {
    if (_formKey.currentState!.fields['season']!.validate()) {
      openModal = true;
      _seasonFocusNode.unfocus();
      _navigateToNextStep();
    }
  }

  @override
  void initState() {
    super.initState();
    _currentValue = (_maxValue >= context.read<EntertainmentEntityProvider>().sagaData['season']) ?
      context.read<EntertainmentEntityProvider>().sagaData['season'] : 1;
  }

  @override
  void dispose() {
    super.dispose();
    _seasonFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EntertainmentEntityProvider entityProvider = context.read<EntertainmentEntityProvider>();
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
                          const SizedBox(height: 30,),
                          (_maxValue < entityProvider.sagaData['season']) ?
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Número actual de temporadas: ${entityProvider.sagaData['season']}",
                                maxLines: 2,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ) : SizedBox(
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
                            ),
                          const SizedBox(height: 10,),
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
              ),
              Positioned(
                bottom: 80,
                right: 24,
                child:  Button(
                  text: '+',
                  buttonWidth: 44,
                  buttonHeight: 44,
                  borderRadius: 40,
                  backgroundSplash: Colors.white,
                  background: AppTheme.primary,
                  action: () {
                    FloatingModal.open(
                      title: 'Ingresa el número de temporadas',
                      body: InputBody(
                        formKey: _formKey,
                        inputName: 'season',
                        currentFocusNode: _seasonFocusNode
                      ),
                      footer: InputFooter(action: _executeValidate)
                    );
                    _seasonFocusNode.requestFocus();
                  }
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}