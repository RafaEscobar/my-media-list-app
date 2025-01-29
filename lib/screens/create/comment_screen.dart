import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';

class CommentScreen extends StatefulWidget {
  static const String routeName = 'comment-screen';
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _commentFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Comentario final:",
                  style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                Input(
                  focusNode: _commentFocusNode,
                  obscureText: false,
                  name: 'comment',
                  maxLines: 8,
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
              ],
            ),
            BottomButtons(
              textBtnLeft: 'Regresar',
              actionBtnL: () => (),
              textBtnRight: 'Continuar',
              actionBtnR: () => (),
            )
          ],
        ),
      )
    );
  }
}