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
            height: 80,
            width: 80,
            child: ClipOval(
              child: Transform.scale(
                scale: 1.6,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 66,
            child: FormTitle(
              title: (title.length >= 10) ? "${title.substring(0, 10)}..." : title,
              textSize: 10,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}