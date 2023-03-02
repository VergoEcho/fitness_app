import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trainings/constants/colors.dart';

class BaseCalendar extends StatefulWidget {
  const BaseCalendar(
      {Key? key,
      this.monthCalendar = true,
      this.headerVisible = false,
      this.focusedDay,
      this.onDaySelected})
      : super(key: key);

  final bool headerVisible;
  final bool monthCalendar;
  final DateTime? focusedDay;
  final Function(DateTime oldDate, DateTime newDate)? onDaySelected;

  @override
  State<BaseCalendar> createState() => _BaseCalendarState();
}

class _BaseCalendarState extends State<BaseCalendar> {

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onCalendarCreated: (controller) {
        pageController = controller;
      },
      onDaySelected: widget.onDaySelected,
      rowHeight: 64,
      locale: context.locale.languageCode,
      // availableGestures: AvailableGestures.none,
      firstDay: DateTime.now().subtract(const Duration(days: 365*5)),
      lastDay: DateTime.now().add(const Duration(days: 365*10)),
      focusedDay: widget.focusedDay ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(widget.focusedDay, day),
      headerVisible: widget.headerVisible,
      calendarFormat:
          widget.monthCalendar ? CalendarFormat.month : CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('MMMM yyyy', context.locale.languageCode)
                        .format(date),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CupertinoTheme.of(context).primaryColor,
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                  },
                  child: const Icon(CupertinoIcons.chevron_back),
                ),
                CupertinoButton(
                  onPressed: () {
                    pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                  },
                  child: const Icon(CupertinoIcons.chevron_forward),
                ),
              ],
            ),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonVisible: false,
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
        isTodayHighlighted: widget.focusedDay == null ? true : false,
        selectedDecoration: BoxDecoration(
          color: FitnessColors.primary,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        todayTextStyle: TextStyle(fontSize: 16, color: FitnessColors.white),
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
