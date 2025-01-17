import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:provider/provider.dart';

class TitleScreen extends StatefulWidget {
  static const String routeName = 'title-screen';
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  final MediaProvider _mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _titleFocusNode = FocusNode();

  String _buildTitle() {
    String title = CategoryEnum.values[_mediaProvider.categoryId-1].name;
    return (_mediaProvider.categoryId == CategoryEnum.movies.identifier || _mediaProvider.categoryId == CategoryEnum.series.identifier) ?
      "Ingresa el título de la ${title.substring(0, title.length-1)}" :
      "Ingresa el título del ${title.substring(0, title.length-1)}";
  }

  void nextStep(){
    try {
      _validateTitle();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void previusStep() => context.pop();

  bool _validateTitle() => _formKey.currentState!.fields['title']!.validate();

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20,),
                Text(
                  _buildTitle(),
                  style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                FormBuilder(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Input(
                      maxLength: 52,
                      showMaxLenght: false,
                      focusNode: _titleFocusNode,
                      obscureText: false,
                      name: 'title',
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blueGrey.shade600),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'El título es obligatorio.'),
                        FormBuilderValidators.maxLength(52, errorText: 'El título debe ser más corto.'),
                        FormBuilderValidators.min(3, errorText: 'El título es muy corto')
                      ]),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        text: 'Regresar',
                        backgroundSplash: Colors.white,
                        textColor: Colors.white,
                        background: Colors.grey.shade500,
                        buttonWidth: size.width * .44,
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        action: previusStep,
                      ),
                      Button(
                        text: 'Continuar',
                        backgroundSplash: Colors.white,
                        textColor: Colors.white,
                        background: AppTheme.primary,
                        buttonWidth: size.width * .44,
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        action: nextStep,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}