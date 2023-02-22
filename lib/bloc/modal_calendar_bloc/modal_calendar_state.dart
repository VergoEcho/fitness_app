part of 'modal_calendar_bloc.dart';

class ModalCalendarState extends Equatable {
  final DateTime selectedDay;

  const ModalCalendarState({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}