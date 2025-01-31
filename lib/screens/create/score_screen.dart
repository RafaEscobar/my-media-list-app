import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/caps_screen.dart';
import 'package:mymedialist/screens/create/comment_screen.dart';
import 'package:mymedialist/screens/create/season_screen.dart';
import 'package:mymedialist/screens/create/status_screen.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/button.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  static const String routeName = 'score-screen';
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  double _currentValue = 5;
  final MediaProvider _mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();

  void _onLess() => setState(() => _currentValue -= 0.1);
  void _onPlus() => setState(() => _currentValue += 0.1);

  void _onNextStep() {
    try {
      _mediaProvider.score = _currentValue;
      if (mounted) context.goNamed(CommentScreen.routeName);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _onPreviousStep(){
    try {
      if (_mediaProvider.subtype == 'Media') {
        context.goNamed(StatusScreen.routeName);
      } else if(_mediaProvider.subtype == 'Saga') {
         (_mediaProvider.type != 'Manga' ? SeasonScreen.routeName : CapsScreen.routeName);
      }
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20,),
                Text(
                  "¿Qué calificación obtuvo?",
                  style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentValue.toStringAsFixed(1),
                      style: const TextStyle(color: AppTheme.primary, fontSize: 40, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const Icon(Icons.grade_outlined, color: AppTheme.primary, size: 30,)
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: '-',
                      backgroundSplash: Colors.white,
                      background: AppTheme.primary,
                      borderRadius: 30,
                      buttonWidth: 53,
                      textSize: 31,
                      textWeight: FontWeight.bold,
                      action: _onLess,
                    ),
                    Button(
                      text: '+',
                      backgroundSplash: Colors.white,
                      background: AppTheme.primary,
                      borderRadius: 30,
                      buttonWidth: 53,
                      textSize: 31,
                      textWeight: FontWeight.bold,
                      action: _onPlus,
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                 SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 10,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
                  ),
                  child: Slider(
                    activeColor: AppTheme.primary,
                    overlayColor: WidgetStatePropertyAll(Colors.blue.shade100),
                    inactiveColor: Colors.black54,
                    value: _currentValue,
                    min: 1,
                    max: 10,
                    divisions: 90,
                    label: _currentValue.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 60,),
                BottomButtons(
                  textBtnLeft: 'Regresar',
                  actionBtnL: _onPreviousStep,
                  textBtnRight: 'Continuar',
                  actionBtnR: _onNextStep,
                )
              ],
            )
          ],
        )
      ),
    );
  }
}