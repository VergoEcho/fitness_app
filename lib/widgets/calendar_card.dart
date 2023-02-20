import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Contact name'),
                SizedBox(height: 2),
                Text(
                  'Comment about',
                  style: TextStyle(fontSize: 14,
                      color: Color(0x963c3c43)),
                ),
                SizedBox(height: 2),
                Text('10:00-10:45'),
              ],
            ),
            const CupertinoButton(onPressed: null,
            child: Icon(Icons.arrow_forward_ios, color: Color(0x963c3c43), size: 16,)),
          ],
        ),
      ),
    );
  }
}