import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/client.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.onTap,
    required this.client,
  });

  final Client client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.name),
                client.clientNote == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          client.clientNote,
                          style: TextStyle(
                              fontSize: 14, color: FitnessColors.darkGray),
                        ),
                      ),
                const SizedBox(height: 2),
                const Text('10:00-10:45'),
              ],
            ),
            CupertinoButton(
              onPressed: null,
              child: Icon(
                Icons.arrow_forward_ios,
                color: FitnessColors.darkGray,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
