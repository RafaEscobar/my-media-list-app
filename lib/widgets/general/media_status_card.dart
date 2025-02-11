import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/comment_step.dart';
import 'package:mymedialist/screens/create/steps/priority_screen.dart';
import 'package:mymedialist/screens/create/steps/score_step.dart';
import 'package:mymedialist/screens/create/steps/season_step.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
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
  late EntertainmentEntityProvider _entityProvider;
  late Widget modalBody;
  late Widget modalFooter;

  void nextStep() {
    try {
      _saveAllStatus();
      _handleRedirect();
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _saveAllStatus() {
    Entertainment.saveField(
      value: widget.status.id,
      fieldName: 'status_id'
    );
    _entityProvider.status = widget.status;
    _entityProvider.isPendingPriority = Entertainment.isInProcessStatus();
  }

  //* #1 - Sí el estatus es de tipo -Media- llamamos al hanldeRedirect ya que no requiere mayor procesamiento
  void _handleRedirect() => _entityProvider.type == TypeEnum.media.name ? _executeRedirect() : _onSaga();

  //* 2B - Execute the modal to ask if we need to add more info
  void _onSaga() => BottomSheetWidget.open(
    title: '¿Quieres agregar más información?',
    body: modalBody,
    footer: modalFooter,
    height: 350,
    withCloseIcon: false
  );

  //* 2B.1 - Set the context variable: -shouldAddMoreInfo- in true
  //* set Evaluate if the status is Pending or Post View
  //* and finally execute the redirect to SeasonScreen
  Future<void> _onMoreInfo() async {
    Navigator.of(context).pop();
    _entityProvider.shouldAddMoreInfo = true;
    Redirect.redirectWithLoader(SeasonScreen.routeName, context);
  }

  Future<void> _onDenyMoreInfo() async {
    Navigator.of(context).pop();
    if (_entityProvider.isPendingPriority) {
      Redirect.redirectWithLoader(PriorityScreen.routeName, context);
    } else {
      Redirect.redirectWithLoader(CommentScreen.routeName, context);
    }
  }

  //* 2A - Evaluate if the status is Pending or Post View
  //* And execute the redirect to the corresponding view
  void _executeRedirect() => (_entityProvider.isPendingPriority) ?
    Redirect.redirectWithLoader(PriorityScreen.routeName, context) :
    Redirect.redirectWithLoader(ScoreScreen.routeName, context);


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
  _entityProvider = context.read<EntertainmentEntityProvider>();
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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