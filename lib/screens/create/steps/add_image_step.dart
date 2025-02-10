import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/mixins/cancel_creation_mixin.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/status_step.dart';
import 'package:mymedialist/screens/create/steps/title_step.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/bottom_sheet_widget.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/forms/round_image.dart';
import 'package:mymedialist/widgets/general/tap_widget.dart';
import 'package:mymedialist/widgets/structures/bottom_buttons.dart';
import 'package:provider/provider.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});
  static const String routeName = 'add-image';

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> with CancelCreationMixin{
  late Widget modalBody;
  late EntertainmentEntityProvider _entityProvider;
  late MultipartFile? _localImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      Navigator.of(context).pop();
      final picker = ImagePicker();
      final newImage = await picker.pickImage(source: source);
      if (null != newImage) {
        Entertainment.saveField(
          value: _buildImage(newImage),
          fieldName: 'image'
        );
      }
    } catch (e) {
      Alert.show(text: e.toString(), contentWidth: 200);
    }
  }

  Future<MultipartFile> _buildImage(XFile image) {
    String title = _entityProvider.type == TypeEnum.media.name ? _entityProvider.mediaData['title'] : _entityProvider.sagaData['title'];
    return MultipartFile.fromFile(image.path, filename: "${title}_image");
  }

  void _selectTypeResource() {
    try {
      BottomSheetWidget.open(
        height: 240,
        withCloseIcon: false,
        dismissible: true,
        title: '¿Dónde buscamos la imagen?',
        body: modalBody
      );
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  Future<void> _navigateToNextStep() async {
    try {
      _validateImage() ?
        await Redirect.redirectWithLoader(StatusScreen.routeName, context) :
        Alert.show(text: 'Debes seleccionar una imagen', contentWidth: 300, background: Colors.red.shade300, centeredText: true, textColor: Colors.white, textSize: 18);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  bool _validateImage() {
    File imageFile = (_entityProvider.type == TypeEnum.media.name) ? _entityProvider.mediaData['image'] : _entityProvider.sagaData['image'];
    return imageFile.path.isEmpty;
  }

  Future<void> _navigateToPreviousStep() async => Redirect.redirectWithLoader(TitleScreen.routeName, context);

  @override
  void initState() {
    super.initState();
    _entityProvider = context.read<EntertainmentEntityProvider>();
    _localImage = (_entityProvider.type == TypeEnum.media.name) ? _entityProvider.mediaData['image'] : _entityProvider.sagaData['image'];
    modalBody = Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 14,
        children: [
          TapWidget(
            width: 340,
            onTap: () => _pickImage(ImageSource.gallery),
            body: Row(
              spacing: 12,
              children: [
                Icon(Icons.photo_size_select_actual_rounded, size: 30, color: Colors.blueGrey.shade700,),
                Text('Galería', style: TextStyle(fontSize: 24, color: Colors.blueGrey.shade700),)
              ],
            ),
          ),
          TapWidget(
            width: 340,
            onTap: () => _pickImage(ImageSource.camera),
            body: Row(
              spacing: 12,
              children: [
                Icon(Icons.camera_alt_outlined, size: 30, color: Colors.blueGrey.shade700,),
                Text('Camara', style: TextStyle(fontSize: 24, color: Colors.blueGrey.shade700),)
              ],
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
               if (didPop) return;
                showModal();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const FormTitle(title: "¿Dónde buscamos la imagen?"),
                      const SizedBox(height: 40,),
                      (null ==_localImage) ?
                        const RoundImage(imagePath: "assets/images/default.jpeg", width: 200, height: 200, type: 'asset',) :
                        RoundImage(imageFilePath: File(_localImage!.filename!) , width: 200, height: 200, type: 'file', borderRadius: BorderRadius.circular(70),)
                    ],
                  ),
                  Column(
                    children: [
                      TapWidget(
                        onTap: _selectTypeResource,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 6,
                            children: [
                              Image.asset('assets/icons/upload.png', width: 26,),
                              Text(
                                'Cargar imagen',
                                style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 21, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      ),
                      const SizedBox(height: 60,),
                      BottomButtons(
                        textBtnLeft: 'Regresar',
                        actionBtnL: _navigateToPreviousStep,
                        textBtnRight: 'Continuar',
                        actionBtnR: _navigateToNextStep,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin:  const EdgeInsets.only(bottom: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}