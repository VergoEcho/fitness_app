import 'package:equatable/equatable.dart';

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
