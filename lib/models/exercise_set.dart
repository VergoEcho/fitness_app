import 'package:trainings/models/series.dart';

class ExerciseSet {
  final int id;
  final DateTime createdAt;
  final List<Series> series;

  ExerciseSet({
    required this.id,
    required this.createdAt,
    required this.series,
  });
}

List<ExerciseSet> setList = [
  ExerciseSet(
    id: 0,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
  ExerciseSet(
    id: 1,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
  ExerciseSet(
    id: 2,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
];

ExerciseSet newExerciseSet = ExerciseSet(
  id: setList.length,
  createdAt: DateTime.now(),
  series: [Series(id: "0", effort: 20, quantity: 10)],
);
