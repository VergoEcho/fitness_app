part of 'exercises_cubit.dart';

enum ExercisesStatus { initial, success, failure }

class ExercisesState extends Equatable {
  final ExercisesStatus status;
  final List<Exercise> exercises;

  const ExercisesState({
    this.exercises = const <Exercise>[],
    required this.status,
  });

  @override
  List<Object?> get props => [exercises, status];
}