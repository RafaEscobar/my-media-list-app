import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/category_model.dart';
import 'package:mymedialist/provider/media_provider.dart';
import 'package:mymedialist/screens/create/title_screen.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/loader.dart';
import 'package:provider/provider.dart';

class MediaTypeCard extends StatefulWidget {
  const MediaTypeCard({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  State<MediaTypeCard> createState() => _MediaTypeCardState();
}

class _MediaTypeCardState extends State<MediaTypeCard> {
  Future<void> nextStep() async {
    try {
      final MediaProvider mediaProvider = navigatorKey.currentState!.context.read<MediaProvider>();
      mediaProvider.categoryId = widget.category.id;
      mediaProvider.type = widget.category.category;
      mediaProvider.subtype = widget.category.subtype;
      await Loader().runLoad(asyncFunction: () async => await Future.delayed(const Duration(milliseconds: 700)), secondsDelayed: 0);
      if (!mounted) return;
      navigatorKey.currentState!.context.goNamed(TitleScreen.routeName);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: nextStep,
          splashColor: Colors.blue.shade50,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  child: SvgPicture.network(
                    widget.category.imageUrl.replaceAll('http://localhost:8000', 'https://fcd7-207-248-115-158.ngrok-free.app'),
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(Colors.blueGrey.shade600, BlendMode.srcIn),
                  ),
                ),
                Text(
                  CategoryEnum.values[widget.category.id-1].name[0].toUpperCase() + CategoryEnum.values[widget.category.id-1].name.substring(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade600),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}