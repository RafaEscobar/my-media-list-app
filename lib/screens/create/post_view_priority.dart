import 'package:flutter/material.dart';

class PostViewPriority extends StatelessWidget{
  const PostViewPriority({super.key});
  static const String routeName = 'post-view-priority';

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(child: Text('Post View Priority'),),
    );
  }
}