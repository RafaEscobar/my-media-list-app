import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.imagePath, required this.title});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ClipOval(
              child: Transform.scale(
                scale: 1.6,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
          FormTitle(
            title: (title.length >= 12) ? "${title.substring(0, 12)}..." : title,
            textSize: 12,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}