import 'package:flutter/material.dart';
import 'package:star_menu/star_menu.dart';

class PendingsScreen extends StatefulWidget {
  const PendingsScreen({super.key});
  static const String routeName = "pending-screen";

  @override
  State<PendingsScreen> createState() => _PendingsScreenState();
}

class _PendingsScreenState extends State<PendingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: StarMenu(
          params: StarMenuParameters(
            shape: MenuShape.linear,
            linearShapeParams: LinearShapeParams(
              angle: 0,
              space: 15,
              alignment: LinearAlignment.left,
            ),
          ),
          items: [
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.home)),
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.search)),
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.settings)),
          ],
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.menu),
          ),
        )
      ),
    );
  }
}