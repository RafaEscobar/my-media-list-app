import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/pending_priority.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/screens/create/season_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/bottom_sheet_widget.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class MediaStatusCard extends StatefulWidget {
  const MediaStatusCard({super.key, required this.status});
  final Status status;

  @override
  State<MediaStatusCard> createState() => _MediaStatusCardState();
}

class _MediaStatusCardState extends State<MediaStatusCard> {
  late Widget modalBody;
  late Widget modalFooter;

  Future<void> nextStep() async {
    try {
      context.read<MediaProvider>().status = widget.status;
      await Loader.runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 400)), secondsDelayed: 0);
      redirectTo();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void redirectTo() => (context.read<MediaProvider>().subtype == 'Media') ? _onMedia() : _onSaga();

  void _onMedia() {
    if (context.read<MediaProvider>().status.status == 'Pendiente' || context.read<MediaProvider>().status.status == 'En emisión') {
      context.goNamed(PendingPriority.routeName);
    } else {
      context.goNamed(ScoreScreen.routeName);
    }
  }

  void _onSaga() => BottomSheetWidget.open(
    title: '¿Quieres agregar más información?',
    body: modalBody,
    footer: modalFooter,
    height: 350,
    withCloseIcon: false
  );

  void _onMoreInfo() {
    Navigator.of(context).pop();
    context.goNamed(SeasonScreen.routeName);
  }
  void _onDenyMoreInfo() {
    Navigator.of(context).pop();
    if (context.read<MediaProvider>().status.status == 'Pendiente' || context.read<MediaProvider>().status.status == 'En emisión') {
      context.goNamed(PendingPriority.routeName);
    } else {
      context.goNamed(ScoreScreen.routeName);
    }
  }

  /*
  * Inicializamos modalFooter y modalBody en el initState sin problema alguno
  *  ya que si bien modalFooter manda a llamar a _onMoreInfo y _onDenyMoreInfo
  * dependen de un contexto valido al usar:
  * -> Navigator.of(context).pop();
  * -> context.goNamed(SeasonScreen.routeName);
  ? Estas funciones NO se ejecutan inmediatamente por lo que le da tiempo suficiente a que
  ? el árbol de Widgest se construya y haya un contexto válido.
  */
  @override
  void initState() {
    super.initState();
    modalFooter = BottomButtons(
      textBtnLeft: 'No',
      actionBtnL: _onDenyMoreInfo,
      textBtnRight: 'Sí',
      actionBtnR: _onMoreInfo,
    );
    modalBody = SizedBox(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '+ ¿Qué temporada es?',
            style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(
            '+ ¿Cuántos capítulos tiene?',
            style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 20, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: nextStep,
          splashColor: Colors.blue.shade50,
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.status.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade600),
                ),
                SizedBox(
                  height: 80,
                  child: Image.asset(
                    widget.status.iconPath,
                    fit: BoxFit.contain,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}