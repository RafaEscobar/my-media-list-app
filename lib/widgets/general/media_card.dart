import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/screens/details/entity_details_screens.dart';
import 'package:mymedialist/theme/app_theme.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.entity
  });
  final Entity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(EntityDetailsScreens.routeName, extra: entity),
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 220,
              width: 180,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    entity.image,
                    fit: BoxFit.contain,
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entity.score != 0 ? '${entity.score}/10' : '---' ,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primary
                          ),
                        ),
                        const Icon(
                          Icons.grade,
                          size: 18,
                          color: AppTheme.primary
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 4, left: 4, bottom: 2),
                  padding: const EdgeInsets.only(top: 2, bottom: 2, right: 6, left: 6),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                    color: AppTheme.primary,
                  ),
                  width: double.infinity,
                  child: Text(
                    entity.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}