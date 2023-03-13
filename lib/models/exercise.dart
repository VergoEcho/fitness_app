import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/generated/locale_keys.g.dart';

List<String> units = [
  LocaleKeys.exercise_page_units_weight_reps.tr(),
  LocaleKeys.exercise_page_units_distance_time.tr(),
  LocaleKeys.exercise_page_units_reps_time.tr(),
  LocaleKeys.exercise_page_units_custom.tr(),
];

Exercise templateExercise = Exercise(
  id: 0,
  title: 'Exercise Name',
  description: 'Distance (km)/Time (min)',
  reps: const [],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

List<Exercise> exercises = [
  Exercise(
    id: 0,
    title: 'Exercise 1',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [
      'Push up • 20 Reps',
      'Push up • 20 Reps',
      'Push up • 20 Reps',
      'Push up • 20 Reps',
    ],
  ),
];

class Exercise extends Equatable {
  final int id;
  final String title;
  final String description;
  final List<String> reps;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Exercise({
    required this.id,
    required this.title,
    this.description = "",
    required this.reps,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, title, description, reps, createdAt, updatedAt];
}
