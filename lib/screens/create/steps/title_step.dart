import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/add_image_step.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class TitleScreen extends StatefulWidget {
  static const String routeName = 'title-screen';
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> with CancelCreationMixin {
  late EntertainmentEntityProvider _entityProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _titleFocusNode = FocusNode();
  late String _title;

  Future<void> _nextStep() async {
    try {
      _titleFocusNode.unfocus();
      if (_validateTitle()) {
        Entertainment.saveField(
          value: _formKey.currentState!.fields['title']!.value.toString(),
          fieldName: 'title',
        );
        Redirect.redirectWithLoader(AddImageScreen.routeName, context);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _onPreviousStep() {
    _entityProvider.deleteData();
    Navigator.of(context).pop();
  }

  bool _validateTitle() => _formKey.currentState!.fields['title']!.validate();

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _entityProvider = context.read<EntertainmentEntityProvider>();
     _title =  (_entityProvider.type == TypeEnum.media.name) ?
        _entityProvider.mediaData['title'] :
        _entityProvider.sagaData['title'];
  }

  /*
  ? Al establecer canPop = false evitamos que Flutter haga algo "automaticamente" al respecto
  ? al momento de hacer la acción de: "hacia atras"
  ? -> AHORA BIEN como evitamos que flutter haga algo en automatico una vez se detone ese evento
  ? -> tenemos la posibilidad de hacer algo nosotros (mandar a llamar al showModal)
  */
  /*
    * FLUJO
    * 1. El usuario detona el evento "back"
    * 2. La acción automatica que flutter haría se cancela por tener canPop = false
    * 3. Por lo que el evento "back" NO SE PROCESO, didPop == true NO SE CUMPLE
    * 4. Entonces podemos llamar a showModal
  */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
               if (didPop) return;
                showModal();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      const FormTitle(title: '¿Cómo se llama?'),
                      const SizedBox(height: 20,),
                      FormBuilder(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Input(
                            initialValue: _title,
                            maxLength: 52,
                            showMaxLenght: false,
                            focusNode: _titleFocusNode,
                            obscureText: false,
                            name: 'title',
                            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blueGrey.shade600),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'El título es obligatorio.'),
                              FormBuilderValidators.maxLength(52, errorText: 'El título debe ser más corto.'),
                              FormBuilderValidators.minLength(3, errorText: 'El título es muy corto')
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                  BottomButtons(
                    textBtnLeft: 'Regresar',
                    textBtnRight: 'Continuar',
                    actionBtnL: _onPreviousStep,
                    actionBtnR: _nextStep,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin:  const EdgeInsets.only(bottom: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}