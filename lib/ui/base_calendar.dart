import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trainings/constants/colors.dart';

class BaseCalendar extends StatelessWidget {
  const BaseCalendar(
      {Key? key, this.monthCalendar = true, this.headerVisible = false, this.focusedDay, this.onDaySelected})
      : super(key: key);

  final bool headerVisible;
  final bool monthCalendar;
  final DateTime? focusedDay;
  final Function(DateTime oldDate, DateTime newDate)? onDaySelected;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: onDaySelected,
      rowHeight: 64,
      locale: context.locale.languageCode,
      availableGestures: AvailableGestures.none,
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2070, 3, 14),
      focusedDay: focusedDay ?? DateTime.now(),
      selectedDayPredicate: (day) =>isSameDay(focusedDay, day),
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
              DateFormat('MMMM, yyyy', context.locale.languageCode).format(DateTime.now()),
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
        headerMargin: const EdgeInsets.only(bottom: 8),
        formatButtonVisible: false,
        rightChevronPadding: const EdgeInsets.all(4),
        leftChevronPadding: const EdgeInsets.all(4),
        leftChevronMargin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width - 104,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 16,
          color: FitnessColors.darkGray,
        ),
        weekendStyle: TextStyle(
          fontSize: 16,
          color: FitnessColors.darkGray,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: focusedDay == null ? true : false,
        selectedDecoration: BoxDecoration(color: FitnessColors.primary, shape: BoxShape.circle,),
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        todayTextStyle:
        TextStyle(fontSize: 16, color: FitnessColors.white),
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
