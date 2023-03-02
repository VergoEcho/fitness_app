part of 'selected_exercise_cubit.dart';

class SelectedExerciseState extends Equatable {

  final Exercise? exercise;

  const SelectedExerciseState({this.exercise});

  @override
  List<Object?> get props => throw [exercise];
}

class SelectedExerciseNone extends SelectedExerciseState {
  const SelectedExerciseNone();
}

class SelectedExerciseSelected extends SelectedExerciseState {
  const SelectedExerciseSelected({super.exercise});
}
