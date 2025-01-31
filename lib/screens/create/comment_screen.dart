import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/post_view_priority.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/loader.dart';
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

  @override
  void dispose() {
    super.dispose();
    _commentFocusNode.dispose();
  }

  Future<void> _onNextStep() async {
    try {
      if (_formKey.currentState!.fields['comment']!.validate()) {
        context.read<MediaProvider>().comment = _formKey.currentState!.fields['comment']!.value.toString();
        await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 400)), secondsDelayed: 0);
        if (mounted) context.goNamed(PostViewPriority.routeName);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _onPreviousStep() => context.goNamed(ScoreScreen.routeName);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          showModal();
        },
        canPop: false,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20,),
                  Text(
                    "Comentario final:",
                    style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  FormBuilder(
                    key: _formKey,
                    child: Input(
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
              )
            ],
          ),
        ),
      )
    );
  }
}