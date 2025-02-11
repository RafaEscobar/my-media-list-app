import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/priority_screen.dart';
import 'package:mymedialist/screens/create/steps/score_step.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  static const String routeName = 'comment-screen';
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with CancelCreationMixin {
  final FocusNode _commentFocusNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _commentController;
  late EntertainmentEntityProvider _entityProvider;

  Future<void> _onNextStep() async {
    try {
      if (_validateComment()) {
        _commentFocusNode.unfocus();
        Entertainment.saveField(
          value: _formKey.currentState!.fields['comment']!.value.toString(),
          fieldName: (_entityProvider.type == TypeEnum.media.name) ? 'comment' : 'final_comment'
        );
        Redirect.redirectWithLoader(PriorityScreen.routeName, context);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  bool _validateComment() => _formKey.currentState!.fields['comment']!.validate();

  Future<void> _onPreviousStep() async => await Redirect.redirectWithLoader(ScoreScreen.routeName, context);

  @override
  void initState() {
    super.initState();
    _entityProvider = navigatorKey.currentState!.context.read<EntertainmentEntityProvider>();
    _commentController = TextEditingController(
      text: (_entityProvider.type == TypeEnum.media.name) ? _entityProvider.mediaData['comment'] : _entityProvider.sagaData['final_comment']
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentFocusNode.dispose();
    _commentFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          showModal();
        },
        canPop: false,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    const FormTitle(title: 'Comentario final:'),
                    const SizedBox(height: 20,),
                    FormBuilder(
                      key: _formKey,
                      child: Input(
                        controller: _commentController,
                        focusNode: _commentFocusNode,
                        obscureText: false,
                        name: 'comment',
                        maxLines: 8,
                        maxLength: 235,
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'El comentario es obligatorio'),
                          FormBuilderValidators.minLength(3, errorText: 'El comentario es demasiado corto'),
                          FormBuilderValidators.maxLength(232, errorText: 'El comentario es muy largo')
                        ]),
                        inputDecoration: InputDecoration(
                          hintText: 'Mi opinión',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primary),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      )
                    )
                  ],
                ),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: _onPreviousStep,
                  textBtnRight: 'Continuar',
                  actionBtnR: _onNextStep,
                  margin: const EdgeInsets.only(bottom: 10),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}