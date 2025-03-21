import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/provider/upload_image_provider.dart';
import 'package:mymedialist/theme/app_theme.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/tap_widget.dart';
import 'package:provider/provider.dart';

class ImageStepOne extends StatefulWidget{
  const ImageStepOne({super.key, required this.nextStep});
  final Function() nextStep;

  @override
  State<ImageStepOne> createState() => _ImageStepOneState();
}

class _ImageStepOneState extends State<ImageStepOne> {
  late UploadImageProvider _uploadImageProvider;

  @override
  void initState() {
    super.initState();
    _uploadImageProvider = context.read<UploadImageProvider>();
  }

  void _closeModal() {
    _uploadImageProvider.cleanData();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          const FormTitle(title: '¿Cuántas imágenes deseas cargar?', maxLines: 2, textSize: 20,),
          SizedBox(height: 20,),
          TapWidget(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.only(left: 24),
            onTap: () => (),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                Text('Una imagen', style: TextStyle(fontSize: 21, color: AppTheme.primary),),
                SvgPicture.asset(
                  "assets/icons/image.svg",
                  height: 26,
                  width: 26,
                  colorFilter: const ColorFilter.mode(AppTheme.primary, BlendMode.srcIn),
                )
              ],
            )
          ),
          SizedBox(height: 10,),
          TapWidget(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.only(left: 24),
            onTap: () => (),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                Text('Varias imagenes', style: TextStyle(fontSize: 21, color: AppTheme.primary),),
                SvgPicture.asset(
                  "assets/icons/images.svg",
                  height: 26,
                  width: 26,
                  colorFilter: const ColorFilter.mode(AppTheme.primary, BlendMode.srcIn),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}