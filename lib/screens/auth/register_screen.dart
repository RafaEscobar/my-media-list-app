import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/utils/call.dart';
import 'package:mymedialist/utils/modal_bottom_sheet.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/modals/rememberme_bottom_sheet.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _lastNFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _lastNFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    try {
      removeFocus();
      if (_validateForm()){
        switch (await _generateRegister()) {
          case 201:
            _onRegisterSuccess();
            break;
          case 422:
            _onEmailIsUsed();
            break;
          default:
            _onRegisterFailure();
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> _getData() => {
      'name': _formKey.currentState!.fields['name']!.value.toString(),
      'last_name': _formKey.currentState!.fields['last_name']!.value.toString(),
      'email': _formKey.currentState!.fields['email']!.value.toString(),
      'password': _formKey.currentState!.fields['password']!.value.toString()
    };

  Future<int> _generateRegister() async {
    int? statusCode;
    await Loader.runLoad( asyncFunction: () async => statusCode =  await _callRegister());
    return statusCode!;
  }

  Future<int> _callRegister() async {
    int statusCode = await appProvider.register(data: _getData());
    if (statusCode == 201) await Call.firstCalls();
    return statusCode;
  }

  bool _validateForm() => _formKey.currentState!.saveAndValidate();

  void _onRegisterSuccess() => ModalBottomSheet.showModal(body: const RemembermeBottomSheet(), height: 200, dismissible: false);

  void _onRegisterFailure() => Alert.show(
      text: 'Error al generar el registro',
      background: Colors.red.shade800,
      textColor: Colors.white,
      contentWidth: (MediaQuery.of(context).size.width * .9),
      duration: const Duration(seconds: 3)
    );

  void _onEmailIsUsed() => Alert.show(
      text: 'El correo electrónico ya esta registrado.',
      background: Colors.red.shade400,
      textColor: Colors.white,
      contentWidth: 360
    );

  void removeFocus(){
    _nameFocusNode.unfocus();
    _lastNFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                const Label(text: 'Nombre:', size: 18,),
                Input(
                  name: 'name',
                  focusNode: _nameFocusNode,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  hintText: 'Raúl',
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 60,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'El nombre es obligatorio.'),
                    FormBuilderValidators.maxLength(32, errorText: 'El nombre es demasiado largo'),
                    FormBuilderValidators.minLength(3, errorText: 'El nombre es muy corto'),
                  ]),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_lastNFocusNode),
                ),
                const SizedBox(height: 30,),
                const Label(text: 'Apellidos:', size: 18,),
                Input(
                  name: 'last_name',
                  focusNode: _lastNFocusNode,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  hintText: 'Casillas',
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 60,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'El apellido es obligatorio.'),
                    FormBuilderValidators.maxLength(48, errorText: 'El apellido es demasiado largo'),
                    FormBuilderValidators.minLength(3, errorText: 'El apellido es muy corto'),
                  ]),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode),
                ),
                const SizedBox(height: 30,),
                const Label(text: 'Correo electrónico:', size: 18,),
                Input(
                  name: 'email',
                  focusNode: _emailFocusNode,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'example@mail.com',
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 60,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Proporciona un correo electrónico'),
                    FormBuilderValidators.email(errorText: 'El correo electrónico no es válido.'),
                    FormBuilderValidators.maxLength(64, errorText: 'La correo es demasiado grande')
                  ]),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocuesNode),
                ),
                const SizedBox(height: 30,),
                const Label(text: 'Contraseña:', size: 18,),
                Input(
                  name: 'password',
                  focusNode: _passwordFocuesNode,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  hintText: '* * * * * * * *',
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 16,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Proporciona una contraseña'),
                    FormBuilderValidators.maxLength(16, errorText: 'La contraseña es demasiado grande'),
                    FormBuilderValidators.minLength(8, errorText: 'La contraseña es demasiado corta'),
                  ]),
                  isPassword: true,
                  onEditingComplete: onSubmit,
                ),
              ],
            ),
          ),
          Button(
            action: onSubmit,
            text: 'Registrarme',
            backgroundSplash: const Color(0xFF3df0fa),
            background: const Color(0xFF1e7df0),
            borderRadius: 20,
            buttonWidth: size.width * .9,
          )
        ],
      ),
    );
  }
}