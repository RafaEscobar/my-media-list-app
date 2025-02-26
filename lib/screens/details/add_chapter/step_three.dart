import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  const StepThree(this.onPreviousStep, this.onNextStep, {super.key});
  final Function() onPreviousStep;
  final Function() onNextStep;

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          ),
          BottomButtons(
            textSize: 18,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(0),
            textBtnLeft: "Regresar",
            actionBtnL: widget.onPreviousStep,
            textBtnRight: "Finzalizar",
            actionBtnR: widget.onNextStep,
          )
        ],
      )
    );
  }
}