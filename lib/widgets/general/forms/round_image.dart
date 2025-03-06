import 'dart:io';

import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  const RoundImage({
    super.key,
    required this.type,
    this.width = 100,
    this.height = 100,
    this.imageFilePath,
    this.imagePath,
    this.borderRadius
  });
  final double width;
  final double height;
  final String? imagePath;
  final File? imageFilePath;
  final String type;
  final BorderRadiusGeometry? borderRadius;

  Image setType(){
    switch (type) {
      case 'asset':
        return Image.asset(imagePath!);
      case 'file':
        return Image.file(imageFilePath!);
      default:
        return Image.asset(imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(140),
      child: SizedBox(
        width: width,
        height: height,
        child: setType(),
      ),
    );
  }
}