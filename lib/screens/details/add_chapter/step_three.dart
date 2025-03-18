import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/screens/details/sections/entity_chapters.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key, required this.chapterKey,required this.onPreviousStep, required this.updateEntity});
  final Function() onPreviousStep;
  final Function() updateEntity;
  final GlobalKey<EntityChaptersState> chapterKey;

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
    _commentFocusNode.unfocus();
    if (_formKey.currentState!.fields['comment']!.validate()) {
      _chapterProvider.comment = _formKey.currentState!.fields['comment']!.value.toString();
      Navigator.of(context).pop();
      await Loader.runLoad(asyncFunction: () async => await _sendRequest()
        .then((response){
          _chapterProvider.cleanData();
          widget.chapterKey.currentState!.refreshChapters();
          _onSuccess();
        })
        .catchError((errorMessage){
          if (mounted) Navigator.of(context).pop();
          _onError(errorMessage.toString());
        }
      ));
    }
  }

  Future<bool> _sendRequest() async {
    if (!await _chapterProvider.createChapter(context)) return false;
    await widget.updateEntity();
    return true;
  }

  void _onError(String message) => Alert.show(
    text: message,
    contentWidth: 340,
    duration: const Duration(seconds: 5),
    textColor: Colors.white,
    background: Colors.red,
    textSize: 16,
    centeredText: true
  );

  void _onSuccess() => Alert.show(
    text: "Capítulo agregado correctamente.",
    contentWidth: 340,
    duration: const Duration(seconds: 3),
    textColor: Colors.white,
    background: Colors.green,
    textSize: 16,
    centeredText: true
  );

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