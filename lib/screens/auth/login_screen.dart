import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  static AppProvider appProvider = navigatorKey.currentContext!.read<AppProvider>();
  bool rememberme = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener((){ if (_emailFocusNode.hasFocus) _formKey.currentState?.fields['email']?.validate(); });
    _passwordFocuesNode.addListener((){ if (_passwordFocuesNode.hasFocus) _formKey.currentState?.fields['password']?.validate(); });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    try {
      _removeFocus();
      if (_validateForm()) (await _generateLogin()) ? _onLoginSucces() : _onLogginFailure();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _removeFocus(){
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  Future<bool> _generateLogin() async {
    bool? isLogged;
    await Loader().runLoad(() async => isLogged = await appProvider.login(credentials: _getCredentials()));
    return isLogged!;
  }

  bool _validateForm() => _formKey.currentState!.saveAndValidate();

  Map<String, dynamic> _getCredentials() => {
    'email': _formKey.currentState!.fields['email']!.value.toString(),
    'password': _formKey.currentState!.fields['password']!.value.toString()
  };

  void _onLoginSucces(){
    Preferences.rememberme = rememberme;
    context.goNamed(MainNavigation.routeName);
  }

  void _onLogginFailure() => Alert.show(
      text: 'Credenciales incorrectas',
      background: Colors.red.shade500,
      textColor: Colors.white,
      contentWidth: (MediaQuery.of(context).size.width * .9),
      duration: const Duration(seconds: 3)
    );

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
                const Label(text: 'Correo electrónico:', size: 18,),
                Input(
                  name: 'email',
                  focusNode: _emailFocusNode,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'example@mail.com' ,
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 60,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Proporciona un correo electrónico'),
                    FormBuilderValidators.email(errorText: 'El correo electrónico no es válido.'),
                    FormBuilderValidators.maxLength(64, errorText: 'La correo es demasiado grande')
                  ]),
                ),
                const SizedBox(height: 36,),
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
                ),
                const SizedBox(height: 20,),
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberme,
                        onChanged: (bool? value) {
                          setState(() => rememberme = value!);
                        },
                      ),
                      InkWell(
                        onTap: () => setState(() => rememberme = !rememberme),
                        child: const Label(text: "Recuerdame")
                      )
                    ],
                  )
                )

              ],
            ),
          ),
          Column(
            children: [
              Button(
                action: onSubmit,
                text: 'Iniciar sesión',
                backgroundSplash: const Color(0xFF3df0fa),
                background: const Color(0xFF1e7df0),
                borderRadius: 20,
                buttonWidth: size.width * .9,
              ),
              const SizedBox(height: 14,),
              const Label(
                text: '¿Olvidaste tu contraseña?',
                size: 13,
                color: Colors.black54,
              ),
            ],
          )
        ],
      ),
    );
  }
}