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
      this.onDaySelected,
      this.oneLetter = false,
      this.eventLoader})
      : super(key: key);

  final bool headerVisible;
  final bool monthCalendar;
  final DateTime? focusedDay;
  final Function(DateTime oldDate, DateTime newDate)? onDaySelected;
  final bool oneLetter;
  final List<dynamic> Function(DateTime)? eventLoader;

  @override
  State<BaseCalendar> createState() => _BaseCalendarState();
}

class _BaseCalendarState extends State<BaseCalendar> {
  late PageController pageController;

  bool isTodayHighlighted() => widget.focusedDay == null ? true : false;

  Widget? _headerTitleBuilder(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateFormat('MMMM yyyy', context.locale.languageCode).format(date),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            child: const Icon(CupertinoIcons.chevron_back),
          ),
          CupertinoButton(
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            child: const Icon(CupertinoIcons.chevron_forward),
          ),
        ],
      ),
    );
  }

  CalendarFormat _calendarFormat() =>
      widget.monthCalendar ? CalendarFormat.month : CalendarFormat.week;

  DateTime _lastDay() => DateTime.now().add(const Duration(days: 365 * 10));

  DateTime _firstDay() =>
      DateTime.now().subtract(const Duration(days: 365 * 5));

  Widget _markerBuilder(
      BuildContext context, DateTime date, List<dynamic> list) {
    List<Widget> markers = [];
    int index = 0;
    for (var _ in list) {
      if (index == 3) break;
      markers.add(
        Container(
          margin: const EdgeInsets.only(left: 2, right: 2),
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 0
                ? FitnessColors.violet
                : index == 1
                    ? FitnessColors.orange
                    : FitnessColors.lightGreen,
          ),
        ),
      );
      index++;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: markers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      eventLoader: widget.eventLoader,
      onCalendarCreated: (controller) {
        pageController = controller;
      },
      onDaySelected: widget.onDaySelected,
      rowHeight: 64,
      locale: context.locale.languageCode,
      // availableGestures: AvailableGestures.none,
      firstDay: _firstDay(),
      lastDay: _lastDay(),
      focusedDay: widget.focusedDay ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(widget.focusedDay, day),
      headerVisible: widget.headerVisible,
      calendarFormat: _calendarFormat(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarBuilders: CalendarBuilders(
        markerBuilder: _markerBuilder,
        headerTitleBuilder: _headerTitleBuilder,
      ),
      headerStyle: const HeaderStyle(
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (DateTime date, dynamic locale) {
          return DateFormat('E', context.locale.languageCode)
              .format(date)
              .toUpperCase()
              .substring(0, widget.oneLetter ? 1 : 3);
        },
        weekdayStyle: TextStyle(
          fontSize: 13,
          color: FitnessColors.ghostGray,
          fontWeight: FontWeight.w600,
        ),
        weekendStyle: TextStyle(
          fontSize: 13,
          color: FitnessColors.ghostGray,
          fontWeight: FontWeight.w600,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: isTodayHighlighted(),
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
        cellMargin: const EdgeInsets.only(top: 10, bottom: 10),
        todayDecoration: BoxDecoration(
          color: CupertinoTheme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
