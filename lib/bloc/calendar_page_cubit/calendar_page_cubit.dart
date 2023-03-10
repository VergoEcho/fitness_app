import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_page_state.dart';

class CalendarPageCubit extends Cubit<CalendarPageState> {
  CalendarPageCubit() : super(CalendarPageState(selectedDay: DateTime.now()));

  void selectDate(DateTime date) {
    emit(CalendarPageState(selectedDay: date));
  }
}