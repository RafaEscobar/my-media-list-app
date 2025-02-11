import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/screens/create/steps/caps_step.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/modals/floating_modal.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:numberpicker/numberpicker.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});
  static const String routeName = 'season-screen';

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> with CancelCreationMixin {
  final FocusNode _seasonFocusNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentValue = 1;
  late Widget body;
  late Widget footer;
  bool openModal = false;

  Future<void> _navigateToNextStep() async {
    try {
      Entertainment.saveField(
        value: !openModal ? _currentValue : _formKey.currentState!.fields['season']!.value.toString(),
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
      _seasonFocusNode.unfocus();
      _navigateToNextStep();
    }
  }

  @override
  void initState() {
    super.initState();
    body = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormBuilder(
        key: _formKey,
        child: Input(
          textStyle: const TextStyle(fontSize: 22),
            name: 'season',
            focusNode: _seasonFocusNode,
            obscureText: false,
            keyboardType: TextInputType.number,
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            maxLength: 3,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Proporciona el número de temporadas'),
              FormBuilderValidators.integer(errorText: 'El valor debe ser númerico'),
              FormBuilderValidators.maxLength(4, errorText: 'Se ingreso un número demasiado grande.')
            ]
          ),
        ),
      )
    );
    footer = SizedBox(
      child: BottomButtons(
        textSize: 18,
        textBtnLeft: 'Cerrar',
        actionBtnL: () => Navigator.of(context).pop(),
        textBtnRight: 'Aceptar',
        actionBtnR: _executeValidate,
        margin: const EdgeInsets.only(bottom: 0),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _seasonFocusNode.dispose();
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
                      SizedBox(
                        height: 260,
                        child: NumberPicker(
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                          selectedTextStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                          itemHeight: 80,
                          infiniteLoop: true,
                          minValue: 1,
                          maxValue: 12,
                          value: _currentValue,
                          onChanged: (value) => setState(() => _currentValue = value),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Button(
                          text: '+',
                          buttonWidth: 44,
                          borderRadius: 40,
                          backgroundSplash: Colors.white,
                          background: AppTheme.primary,
                          action: () {
                            FloatingModal.open(
                              title: 'Ingresa el número de temporadas',
                              body: body,
                              footer: footer
                            );
                            _seasonFocusNode.requestFocus();
                          }
                        )
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