import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/category_provider.dart';
import 'package:mymedialist/widgets/general/forms/form_title.dart';
import 'package:mymedialist/widgets/general/media_type_card.dart';
import 'package:provider/provider.dart';

class TypeScreen extends StatefulWidget {
  static const String routeName = 'type-screen';
  const TypeScreen({super.key});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  final CategoryProvider _categoryProvider = navigatorKey.currentState!.context.read<CategoryProvider>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const FormTitle(title: '¿Qué vas a calificar?'),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 28,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2 /2.4,
                  ),
                  itemCount: _categoryProvider.categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MediaTypeCard(category: _categoryProvider.categoryList[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

