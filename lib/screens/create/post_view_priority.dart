import 'package:flutter/material.dart';
import 'package:mymedialist/provider/post_view_priority_provider.dart';
import 'package:provider/provider.dart';

class PostViewPriority extends StatelessWidget{
  const PostViewPriority({super.key});
  static const String routeName = 'post-view-priority';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: Text('Post View Priority ${context.read<PostViewPriorityProvider>().postViewPriorityList.length}'),),
    );
  }
}