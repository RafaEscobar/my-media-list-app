import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymedialist/enum/category_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/category_model.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/screens/create/steps/title_step.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:mymedialist/widgets/general/tap_widget.dart';
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
  late EntertainmentEntityProvider entityProvider;

  Future<void> _nextStep() async {
    try {
      _saveTypes();
      Entertainment.saveField(
        fieldName: "category_id",
        value: widget.category.id,
      );
      await Redirect.redirectWithLoader(TitleScreen.routeName, context);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  void _saveTypes(){
    entityProvider.category = widget.category.category;
    entityProvider.type = widget.category.subtype;
  }

  @override
  void initState() {
    super.initState();
    entityProvider = navigatorKey.currentState!.context.read<EntertainmentEntityProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      borderRadius: BorderRadius.circular(10),
      onTap: _nextStep,
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 120,
              child: SvgPicture.network(
                widget.category.imageUrl,
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
    );
  }
}