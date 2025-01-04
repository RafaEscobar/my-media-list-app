
import 'package:flutter/material.dart';
import 'package:mymedialist/screens/navigation/main_navigation.dart';

void main()
{
  return runApp(const MyClass());
}

class MyClass extends StatelessWidget
{
  const MyClass({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}