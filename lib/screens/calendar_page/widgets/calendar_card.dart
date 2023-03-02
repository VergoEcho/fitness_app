import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/calendar_page_cubit/calendar_page_cubit.dart';
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

  String _time(BuildContext context) {
    DateTime selectedDay = context.read<CalendarPageCubit>().state.selectedDay;
    TimeOfDay startTime = client.trainingDays[DateFormat(
      'EEEE',
      'en-US',
    ).format(selectedDay).toLowerCase()]!;
    return '${startTime.format(context)} - ${startTime.replacing(hour: startTime.hour + 1).format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
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
                Text(
                  client.name,
                  style: const TextStyle(fontSize: 16),
                ),
                client.clientNote == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          client.clientNote,
                          style: TextStyle(
                              fontSize: 14, color: FitnessColors.blindGray),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    _time(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
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
