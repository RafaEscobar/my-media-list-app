import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/provider/category_provider.dart';
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
  //* NodeFocus
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  //* Key by form
  final _formKey = GlobalKey<FormBuilderState>();
  //* Providers
  final AppProvider _appProvider = navigatorKey.currentContext!.read<AppProvider>();
  final CategoryProvider _categoryProvider =  navigatorKey.currentState!.context.read<CategoryProvider>();
  //* Global variables
  bool rememberme = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    try {
      _removeFocus();
      if (_validateForm()) (await _generateLogin()) ? await _onLoginSucces() : _onLogginFailure();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _removeFocus(){
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  bool _validateForm() => _formKey.currentState!.saveAndValidate();

  Future<bool> _generateLogin() async {
    bool? isLogged;
    await Loader().runLoad( asyncFunction: () async => isLogged = await _appProvider.login(credentials: _getCredentials()) );
    return isLogged!;
  }

  Map<String, dynamic> _getCredentials() => {
    'email': _formKey.currentState!.fields['email']!.value.toString(),
    'password': _formKey.currentState!.fields['password']!.value.toString()
  };

  Future<void> _onLoginSucces() async {
    Preferences.rememberme = rememberme;
    await _loadFirstCalls();
    if (!mounted) return;
    context.goNamed(MainNavigation.routeName);
  }

  Future<void> _loadFirstCalls() async {
    await _categoryProvider.getCategories();
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
                  onEditingComplete: (){
                    FocusScope.of(context).requestFocus(_passwordFocuesNode);
                  },
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
                  onEditingComplete: onSubmit,
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