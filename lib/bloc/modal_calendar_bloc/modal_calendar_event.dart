part of 'modal_calendar_bloc.dart';

abstract class ModalCalendarEvent extends Equatable {}

class SelectedDay extends ModalCalendarEvent {
  final DateTime selectedDay;

  SelectedDay({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];

}


