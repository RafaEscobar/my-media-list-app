import 'package:flutter/material.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:mymedialist/utils/entertainment.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class PriorityCard extends StatelessWidget {
  const PriorityCard({super.key, required this.priority});
  final Priority priority;

  Future<void> _onSelectPriority(BuildContext context) async {
    try {
      EntertainmentEntityProvider entityProvider = context.read<EntertainmentEntityProvider>();
      Entertainment.saveField(
        value: priority.id,
        fieldName: entityProvider.isPendingPriority ? 'pending_priority_id' : 'post_view_priority_id'
      );
      await entityProvider.createMedia(context);
    } catch (e) {
      Alert.show(text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _onSelectPriority(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(
                      priority.priority,
                      style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 22, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        maxLines: 2,
                        priority.description,
                        style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 16, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}