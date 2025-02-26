import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/empty_state.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});
  static const String routeName = "search-screen";

  @override
  Widget build(BuildContext context) {
    return const EmptyState(title: 'Próximamente', lottieName: 'soon');
  }
}