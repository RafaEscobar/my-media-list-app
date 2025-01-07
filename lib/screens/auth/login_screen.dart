import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/general/input.dart';
import 'package:mymedialist/widgets/general/label.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  final _formKey = GlobalKey<FormBuilderState>();
  static AppProvider appProvider = navigatorKey.currentContext!.read<AppProvider>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener((){if (_emailFocusNode.hasFocus) _formKey.currentState?.fields['email']?.validate(); });
    _passwordFocuesNode.addListener((){ if (_passwordFocuesNode.hasFocus) _formKey.currentState?.fields['password']?.validate(); });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    removeFocus();
    bool? isValidated = _formKey.currentState?.saveAndValidate();
    Map<String, dynamic> body = {'email': _emailController.text, 'password': _passwordController.text};
    if (isValidated!) {
      bool isLogged = await appProvider.login(body);
      if (isLogged) {
        if (mounted) context.goNamed(MainNavigation.routeName);
      } else {
        if (!mounted) return;
        Size size = MediaQuery.of(context).size;
        Alert.show(
          text: 'Credenciales incorrectas',
          background: Colors.red.shade500,
          textColor: Colors.white,
          contentWidth: (size.width * .82),
          duration: const Duration(seconds: 3)
        );
      }
    }
  }

  void removeFocus(){
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'example@mail.com',
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  maxLength: 60,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Proporciona un correo electrónico'),
                    FormBuilderValidators.email(errorText: 'El correo electrónico no es válido.'),
                    FormBuilderValidators.maxLength(32, errorText: 'La correo es demasiado grande')
                  ]),
                ),
                const SizedBox(height: 36,),
                const Label(text: 'Contraseña:', size: 18,),
                Input(
                  controller: _passwordController,
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
                ),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Label(text: '¿Olvidaste tu contraseña?', size: 13, color: Colors.black54, ),
                ),
              ],
            ),
          ),
          Button(
            action: onSubmit,
            text: 'Iniciar sesión',
            backgroundSplash: const Color(0xFF3df0fa),
            background: const Color(0xFF1e7df0),
            borderRadius: 20,
          )
        ],
      ),
    );
  }
}