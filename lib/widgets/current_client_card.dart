import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/client_profile_page.dart';
import 'package:trainings/ui/base_calendar.dart';

class CurrentClientCard extends StatelessWidget {
  const CurrentClientCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(ClientProfilePage.route, arguments: {"client": client}),
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
                  children: [
                    Text(client.name),
                    const SizedBox(height: 2),
                    client.clientNote == ""
                        ? const SizedBox()
                        : Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                              client.clientNote,
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0x963c3c43)),
                            ),
                        ),
                    const Text('10:00-10:45'),
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
