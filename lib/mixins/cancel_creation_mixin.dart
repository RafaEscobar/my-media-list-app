

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';
import 'package:mymedialist/widgets/general/bottom_sheet_widget.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';

mixin CancelCreationMixin {
    void showModal(){
        BottomSheetWidget.open(
          height: 200,
          withCloseIcon: false,
          dismissible: true,
          title: '¿Estás seguro de que deseas salir?',
          footer: SizedBox(
            child: BottomButtons(
              textBtnLeft: 'Salir',
              actionBtnL: () => navigatorKey.currentState!.context.goNamed(MainNavigation.routeName),
              backgroundBtnL: Colors.red.shade500,
              textColorBtnL: Colors.white,
              textBtnRight: 'Continuar',
              actionBtnR: () => Navigator.of(navigatorKey.currentState!.context).pop(),
            ),
          )
        );
    }
}