import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const String routeName = "search-screen";

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("Buscar"),
      ),
    );
  }
}