import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modal_calendar_state.dart';

class ModalCalendarCubit extends Cubit<ModalCalendarState> {
  ModalCalendarCubit()
      : super(ModalCalendarState(selectedDay: DateTime.now()));

  void selectDate(DateTime date) => emit(ModalCalendarState(selectedDay: date));
}
