import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/models/exercise.dart';

part 'selected_exercise_state.dart';

class SelectedExerciseCubit extends Cubit<SelectedExerciseState> {
  SelectedExerciseCubit() : super(const SelectedExerciseNone());

  void select({required Exercise exercise}) {
    emit(SelectedExerciseSelected(exercise: exercise));
  }
  void clear() {
    emit(const SelectedExerciseNone());
  }
}
