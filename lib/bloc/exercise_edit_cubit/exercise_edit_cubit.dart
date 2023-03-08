import 'package:bloc/bloc.dart';

part 'exercise_edit_state.dart';

class ExerciseEditCubit extends Cubit<ExerciseEditState> {
  ExerciseEditCubit() : super(ExerciseCreateMode());

  void changeMode (ExerciseEditState mode) {
    emit(mode);
  }
}
