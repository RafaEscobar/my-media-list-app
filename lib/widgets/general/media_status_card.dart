import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/pending_priority.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/widgets/general/bottom_sheet_widget.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class MediaStatusCard extends StatefulWidget {
  const MediaStatusCard({super.key, required this.status});
  final Status status;

  @override
  State<MediaStatusCard> createState() => _MediaStatusCardState();
}

class _MediaStatusCardState extends State<MediaStatusCard> {
  Future<void> nextStep() async {
    BottomSheetWidget.open(
      title: '¿Quieres agregar más información?',
      body: modalBody,
      footer: modalFooter,
      height: 350,
    );
    /*
    try {
      context.read<MediaProvider>().status = widget.status;
      redirectTo();
    } catch (e) {
      Alert.show(text: e.toString());
    }
    */
  }

  Widget modalBody = SizedBox(
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

  Widget modalFooter = BottomButtons(
    textBtnLeft: 'No',
    actionBtnL: () => (),
    textBtnRight: 'Sí',
    actionBtnR: () => (),
  );

  void redirectTo(){
    if (context.read<MediaProvider>().subtype == 'Media') {
      if (context.read<MediaProvider>().status.status == 'Pendiente' || context.read<MediaProvider>().status.status == 'En emisión') {
        context.goNamed(PendingPriority.routeName);
      } else {
        context.goNamed(ScoreScreen.routeName);
      }
    } else if (context.read<MediaProvider>().subtype == 'Saga'){
      // modal
    }
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