import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/caps_screen.dart';
import 'package:mymedialist/screens/create/pending_priority.dart';
import 'package:mymedialist/screens/create/score_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:provider/provider.dart';

class MediaStatusCard extends StatefulWidget {
  const MediaStatusCard({super.key, required this.status});
  final Status status;

  @override
  State<MediaStatusCard> createState() => _MediaStatusCardState();
}

class _MediaStatusCardState extends State<MediaStatusCard> {
  Future<void> nextStep() async {
    try {
      context.read<MediaProvider>().status = widget.status;
      await Loader().runLoad(asyncFunction: () async => Future.delayed(const Duration(milliseconds: 700)) );
      redirectTo();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void redirectTo(){
    if (context.read<MediaProvider>().status.status == 'Pendiente' || context.read<MediaProvider>().status.status == 'En emisión') {
      context.goNamed(PendingPriority.routeName);
    } else {
      (context.read<MediaProvider>().subtype== 'Saga') ?
        context.goNamed(CapsScreen.routeName) :
        context.goNamed(ScoreScreen.routeName);
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