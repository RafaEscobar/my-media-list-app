import 'package:flutter/material.dart';
import 'package:mymedialist/models/status.dart';

class MediaStatusCard extends StatelessWidget {
  const MediaStatusCard({super.key, required this.status});
  final Status status;

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
          onTap: () => (),
          splashColor: Colors.blue.shade50,
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  status.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade600),
                ),
                SizedBox(
                  height: 80,
                  child: Image.asset(
                    status.iconPath,
                    fit: BoxFit.contain,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}