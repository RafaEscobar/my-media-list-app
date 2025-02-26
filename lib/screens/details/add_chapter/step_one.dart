import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/provider/chapter_provider.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class StepOne extends StatefulWidget{
  const StepOne(this.nextStep, {super.key,});
  final Function() nextStep;

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _nameFocusNode = FocusNode();
  late ChapterProvider _chapterProvider;

  @override
  void initState() {
    super.initState();
    _chapterProvider = context.read<ChapterProvider>();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    if (_formKey.currentState!.fields['name']!.validate()) {
      _chapterProvider.name = _formKey.currentState!.fields['name']!.value.toString();
      widget.nextStep;
    }
  }

  void _closeModal() {
    _chapterProvider.cleanData();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 260,
      padding: const EdgeInsets.only(right: 2, left: 2, top: 4, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FormTitle(title: 'Nombre o número del capítulo:', maxLines: 2, textSize: 20,),
          FormBuilder(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Input(
                maxLength: 60,
                showMaxLenght: false,
                focusNode: _nameFocusNode,
                obscureText: false,
                name: 'name',
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blueGrey.shade600),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'El nombre es obligatorio.'),
                  FormBuilderValidators.maxLength(60, errorText: 'El título debe ser más corto.'),
                ]),
              ),
            ),
          ),
          BottomButtons(
            textSize: 18,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(0),
            textBtnLeft: "Cerrar",
            actionBtnL: _closeModal,
            textBtnRight: "Continuar",
            actionBtnR: _navigateToNext,
          )
        ],
      )
    );
  }
}