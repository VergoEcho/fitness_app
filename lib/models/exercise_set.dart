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
