import 'package:flutter/material.dart';
import 'package:mymedialist/theme/app_theme.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});
  static const String routeName = "search-screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: 230,
      child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    width: 170,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          width: 180,
                          "https://img.thegoodocs.com/templates/preview/aesthetic-indie-movie-poster-163161.webp",
                          fit: BoxFit.contain,
                        )
                      )
                    ),
                  ),
                  Container(
                    width: 170,
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("currentEntity.status", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white), textAlign: TextAlign.center,),
                  )
                ],
              )
            ),
          ],
        )
    );
  }
}