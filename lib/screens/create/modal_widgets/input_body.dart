import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/widgets/general/input.dart';

class InputBody extends StatelessWidget {
  const InputBody({
    super.key,
    required this.formKey,
    required this.inputName,
    required this.currentFocusNode
  });
  final GlobalKey<FormBuilderState> formKey;
  final String inputName;
  final FocusNode currentFocusNode;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormBuilder(
        key: formKey,
        child: Input(
          textStyle: const TextStyle(fontSize: 22),
            name: inputName,
            focusNode: currentFocusNode,
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
  }
}