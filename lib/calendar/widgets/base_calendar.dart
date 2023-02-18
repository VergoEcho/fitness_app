import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BaseCalendar extends StatelessWidget {
  const BaseCalendar(
      {Key? key, this.monthCalendar = true, this.headerVisible = false, this.focusedDay})
      : super(key: key);

  final bool headerVisible;
  final bool monthCalendar;
  final DateTime? focusedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      availableGestures: AvailableGestures.none,
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2070, 3, 14),
      focusedDay: focusedDay ?? DateTime.now(),
      headerVisible: headerVisible,
      calendarFormat:
          monthCalendar ? CalendarFormat.month : CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarBuilders: CalendarBuilders(headerTitleBuilder: (context, date) {
        return Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: -8,
            right: MediaQuery.of(context).size.width - 196,
            child: Text(
              DateFormat('MMMM, yyyy').format(DateTime.now()),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 0,
          ),
        ]);
      }),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronPadding: const EdgeInsets.all(4),
        leftChevronPadding: const EdgeInsets.all(4),
        leftChevronMargin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width - 104,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 16,
          color: Color(0x963c3c43),
        ),
        weekendStyle: TextStyle(
          fontSize: 16,
          color: Color(0x963c3c43),
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        todayTextStyle:
            const TextStyle(fontSize: 16, color: CupertinoColors.white),
        weekendTextStyle: const TextStyle(
          fontSize: 16,
        ),
        cellMargin: const EdgeInsets.only(top: 16),
        todayDecoration: BoxDecoration(
          color: CupertinoTheme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
