import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/calendar/calendar.dart';

import '../view/views.dart';

class CurrentClientCard extends StatelessWidget {
  const CurrentClientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ClientProfilePage.route),
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
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
                      style: TextStyle(fontSize: 14, color: Color(0x963c3c43)),
                    ),
                    SizedBox(height: 2),
                    Text('10:00-10:45'),
                  ],
                ),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0x963c3c43),
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            const BaseCalendar(
              monthCalendar: false,
            ),
          ],
        ),
      ),
    );
  }
}