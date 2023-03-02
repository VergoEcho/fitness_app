import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/models/exercise.dart';

part 'exercises_state.dart';

List<Exercise> _exercises = [
  Exercise(
    id: 0,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
  Exercise(
    id: 1,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
];

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit()
      : super(const ExercisesState(status: ExercisesStatus.initial));
  
  void fetchExercises() {
    emit(ExercisesState(status: ExercisesStatus.success, exercises: _exercises));
  }
}
