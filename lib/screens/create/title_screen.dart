import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class TitleScreen extends StatefulWidget {
  static const String routeName = 'title-screen';
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late MediaProvider _mediaProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _titleFocusNode = FocusNode();

  String _buildTitle() {
    String title = CategoryEnum.values[_mediaProvider.categoryId-1].name;
    return (_mediaProvider.categoryId == CategoryEnum.movies.identifier || _mediaProvider.categoryId == CategoryEnum.series.identifier) ?
      "Ingresa el título de la $title" :
      "Ingresa el título del $title";
  }

  Future<void> _nextStep() async {
    _titleFocusNode.unfocus();
    try {
      if (_validateTitle()) {
        _mediaProvider.title = _formKey.currentState!.fields['title']!.value.toString();
        await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 400)), secondsDelayed: 0);
        if (mounted) context.goNamed(StatusScreen.routeName);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _previusStep() {
    context.read<MediaProvider>().title = '';
    context.pop();
  }

  bool _validateTitle() => _formKey.currentState!.fields['title']!.validate();

  @override
  void initState() {
    super.initState();
    _mediaProvider = context.read<MediaProvider>();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Container(
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
                        initialValue: context.watch<MediaProvider>().title,
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
                actionBtnL: _previusStep,
                actionBtnR: _nextStep,
                padding: const EdgeInsets.symmetric(vertical: 8),
              )
            ],
          ),
        ),
      )
    );
  }
}