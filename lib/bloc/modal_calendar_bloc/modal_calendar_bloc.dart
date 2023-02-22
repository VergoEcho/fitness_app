import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modal_calendar_event.dart';
part 'modal_calendar_state.dart';

class ModalCalendarBloc extends Bloc<ModalCalendarEvent, ModalCalendarState> {
  ModalCalendarBloc() : super(ModalCalendarState(selectedDay: DateTime.now())) {
    on<SelectedDay>(_selectedDay);
  }

  _selectedDay(SelectedDay event, Emitter<ModalCalendarState> emit) {
    print(event.selectedDay);
    emit(ModalCalendarState(selectedDay:event.selectedDay));
  }
}
