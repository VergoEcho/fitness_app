part of 'calendar_page_cubit.dart';

@immutable
class CalendarPageState extends Equatable {
  final DateTime selectedDay;

  const CalendarPageState({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}
