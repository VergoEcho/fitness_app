import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:trainings/calendar/widgets/widgets.dart';

class CalendarTrainingPage extends StatelessWidget {
  const CalendarTrainingPage({Key? key}) : super(key: key);

  static const route = '/calendarTraining';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffafafa),
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: CupertinoColors.white),
        backgroundColor: CupertinoColors.white,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 0),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.arrow_back_ios_new,
              ),
              Text('Back')
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: const Text('Client Name'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Training Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Text(DateFormat('dd.mm.yy')
                        .format(DateTime.now())
                        .toString())
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Training notes with long long text',
                  style: TextStyle(fontSize: 14, color: Color(0xff8a8a8e)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 16,
                      ),
                      child: CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        minSize: 32,
                        onPressed: () {},
                        child: Text(
                          'New Template'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CalendarExerciseCard();
                    return null;
                  },
                ),
                const SizedBox(height: 200,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
