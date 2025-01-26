import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/provider/status_provider.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:mymedialist/widgets/general/media_status_card.dart';
import 'package:provider/provider.dart';

class StatusScreen extends StatefulWidget {
  static const String routeName = 'status-screen';
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final StatusProvider _statusProvider = navigatorKey.currentState!.context.read<StatusProvider>();
  Future<void> nextStep() async {
    try {
      context.read<MediaProvider>().statusId = 0;
      await Loader().runLoad(asyncFunction: () async => Future.delayed(const Duration(milliseconds: 700)) );
      // Aqui vamos a verificar:
      /*
        !
      */
      //if (mounted) context.goNamed();
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
          children: [
            Text(
              "¿Cuál es el estatus actual del contenido?",
              style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 26, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _statusProvider.statusList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2/2
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MediaStatusCard(status: _statusProvider.statusList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}