import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  const StepThree(this.onPreviousStep, {super.key});
  final Function() onPreviousStep;

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _commentFocusNode = FocusNode();
  late ChapterProvider _chapterProvider;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _chapterProvider = context.read<ChapterProvider>();
    _commentController = TextEditingController(text: _chapterProvider.comment.isNotEmpty ? _chapterProvider.comment : '');
  }

  Future<void> _navigateToNext() async {
    try {
      _commentFocusNode.unfocus();
      if (_formKey.currentState!.fields['comment']!.validate()) {
        _chapterProvider.comment = _formKey.currentState!.fields['comment']!.value.toString();
        Loader.runLoad(asyncFunction: () async => await _chapterProvider.createChapter(context).then((response){
          if (response) {
            _chapterProvider.cleanData();
            if (mounted) context.pop();
          }
        }));
      }
    } catch (e) {
      Alert.show(text: e.toString(), contentWidth: 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.only(right: 2, left: 2, top: 4, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FormTitle(title: 'Comentario:', maxLines: 2, textSize: 20,),
          FormBuilder(
            key: _formKey,
            child: Input(
              controller: _commentController,
              focusNode: _commentFocusNode,
              obscureText: false,
              name: 'comment',
              maxLines: 4,
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
          ),
          BottomButtons(
            textSize: 18,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(0),
            textBtnLeft: "Regresar",
            actionBtnL: widget.onPreviousStep,
            textBtnRight: "Finzalizar",
            actionBtnR: _navigateToNext,
          )
        ],
      )
    );
  }
}